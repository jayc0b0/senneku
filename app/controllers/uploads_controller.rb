class UploadsController < ApplicationController
  def index
    @uploads = Upload.order('created_at')
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)
    if @upload.save
      flash[:success] = "File uploaded"
      redirect_to root_path
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

  private

  def upload_params
    params.require(:upload).permit(:upload, :filename)
  end
end
