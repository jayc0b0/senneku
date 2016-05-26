class UploadsController < ApplicationController
  def index
    @uploads = Upload.order('created_at')
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)
    # Set default deletion time
    @upload.delete_in = 14 if @upload.delete_in.nil?
    @upload.delete_on = Time.now + @upload.delete_in.days
    # Set click tracking to false if nothing set
    @upload.track_clicks = false if @upload.track_clicks.nil?
    @upload.click_limit = -1 if @upload.track_clicks == false
    # Set click count to 0
    @upload.click_count = 0

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
  end

  private

  def upload_params
    params.require(:upload).permit(:upload, :filename, :delete_in, :track_clicks, :click_limit)
  end
end
