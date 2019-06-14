require 'googleauth'
require 'google/apis/drive_v3'

class FilesController < ApplicationController
  before_action :auth_drive

  Drive = ::Google::Apis::DriveV3

  def index

    @result = @drive_service.list_files(page_size: 20,
                               fields: 'files(name,modified_time,web_view_link),next_page_token')
  end

  def create

    uploaded_file = file_upload_param[:file]
    output_path = uploaded_file.original_filename

    File.open(output_path, 'w+b') do |fp|
      fp.write  uploaded_file.read
    end

    file_metadata = {
        name: uploaded_file.original_filename
    }
    file = @drive_service.create_file(file_metadata,
                                     fields: 'id',
                                     upload_source: output_path,
                                     content_type: 'image/jpeg')

    create_permission(file.id, ENV['DRIVE_ACCOUNT_EMAIL'])

    FileUtils.rm output_path

    redirect_to action: 'index'

  end

  private

  def auth_drive
    @drive_service = Drive::DriveService.new

    auth = ::Google::Auth::ServiceAccountCredentials
               .make_creds(scope: 'https://www.googleapis.com/auth/drive')
    @drive_service.authorization = auth

  end

  def create_permission(file_id, email)

    user_permission = {
        type: 'user',
        role: 'writer',
        email_address: email
    }
    @drive_service.create_permission(file_id,
                                     user_permission,
                                     fields: 'id')
  end

  def file_upload_param
    params.require(:fileupload).permit(:file)
  end
end
