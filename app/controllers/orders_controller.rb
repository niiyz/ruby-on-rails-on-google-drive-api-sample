require 'googleauth'
require 'google/apis/drive_v3'

class OrdersController < ApplicationController

  Drive = ::Google::Apis::DriveV3

  def index

    drive = Drive::DriveService.new

    auth = ::Google::Auth::ServiceAccountCredentials
               .make_creds(scope: 'https://www.googleapis.com/auth/drive')
    drive.authorization = auth

    list_files = drive.list_files()

    logger.debug list_files

    render plain: list_files.to_s
  end

end
