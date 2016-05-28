class UploadsController < ApplicationController
  def index
    @uploads = Upload.order('created_at')
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)
    # Before save
    # Set default deletion time
    @upload.delete_in = 14 if @upload.delete_in.nil?
    @upload.delete_on = Time.now + @upload.delete_in.days
    # Set click tracking to false if nothing set
    @upload.track_clicks = false if @upload.track_clicks.nil?
    @upload.click_limit = -1 if @upload.track_clicks == false
    # Set click count to 0
    @upload.click_count = 0

    ## TESTING SETTINGS
    if @upload.upload_file_name == "test.jpg"
      @upload.delete_on = Time.now - 1.day
    end

    ## SUPER HACKY WAY TO FIX DOUBLE INCREMENT BUG
    ## (SETS CLICK LIMIT TO DOUBLE VALUE TO GET AROUND IT)
    ## PLZ FIX AT SOME POINT
    @upload.click_limit *= 2 if @upload.track_clicks = true

    if @upload.save
      flash[:success] = "File uploaded"
      redirect_to upload_path(@upload)
    else
      render 'new'
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
    flash[:success] = "File deleted"
    redirect_to root_path
  end

  def show
    @upload = Upload.find(params[:id])
  end

  def download
    @upload = Upload.find_by_id(params[:id])
    # Catch nil records
    unless @upload.nil?
      # Check expiration date
      if @upload.delete_on.past?
        destroy
        not_found
      end
      # Increment click count
      @upload.click_count += 1
      @upload.save
      # Check if click count is above limit
      if @upload.click_count > @upload.click_limit
        destroy
        not_found
      else
        file_path = "#{@upload.upload.path}"
        send_file(file_path)
      end
    end
    # Redirect if nil
    if @upload.nil?
      not_found
    end
  end

  def not_found
    render :file => "#{Rails.root}/public/404.html"
  end

  private

  def upload_params
    params.require(:upload).permit(:upload, :delete_in, :track_clicks, :click_limit, :id)
  end
end
