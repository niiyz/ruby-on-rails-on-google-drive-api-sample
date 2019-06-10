require 'googleauth'
require 'google/apis/drive_v3'

class OrdersController < ApplicationController
  before_action :auth_drive

  Drive = ::Google::Apis::DriveV3

  def index

    @result = @drive_service.list_files(page_size: 10,
                               fields: 'files(name,modified_time,web_view_link),next_page_token')
  end

  def create

    file_metadata = {
        name: 'photo.jpg'
    }
    file = @drive_service.create_file(file_metadata,
                                     fields: 'id',
                                     upload_source: 'photo.jpg',
                                     content_type: 'image/jpeg')
    puts "File Id: #{file.id}"

    create_permission(file.id)

  end

  def create_permission(file_id)

    user_permission = {
        type: 'user',
        role: 'writer',
        email_address: 'yoshida@niiyz.com'
    }
    @drive_service.create_permission(file_id,
                              user_permission,
                              fields: 'id')
  end

  private

  def auth_drive
    @drive_service = Drive::DriveService.new

    auth = ::Google::Auth::ServiceAccountCredentials
               .make_creds(scope: 'https://www.googleapis.com/auth/drive')
    @drive_service.authorization = auth

  end
end
