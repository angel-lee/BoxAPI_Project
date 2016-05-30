class LoginController < ApplicationController
  def index
  end

  # handles customer login
  def login
  	client = Boxr::Client.new('PLmOqa5ejaSjFjslpnvLbQjx48gFSAbp')
	parentFolder = client.folder_from_path('/Uploaded Documents')
	name = 'Angel Lee'

	begin
		client.folder_from_path('/Uploaded Documents/' + name)
		redirect_to documents_index_path

	rescue Boxr::BoxrError => e
		client.create_folder(name, parentFolder)
		redirect_to documents_index_path
	end
  end
end
