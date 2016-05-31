class LoginController < ApplicationController
	before_filter :get_client

	# get the client, sets root folder
  	def get_client
    	@client = Boxr::Client.new('OIKx5i9kZTKwlVeBcHATgUdyqmYqVkPR')
    	# @client = params[:client]
    	# puts @client
    	@home_folder_name = '/Uploaded Documents/'
		@parent_folder = @client.folder_from_path(@home_folder_name)
		@user_name = @client.current_user.name
		@user_folder_name = @home_folder_name + @user_name
  	end	

  def index
  end

  # handles customer login
  def login
	begin
		@client.folder_from_path(@user_folder_name)
		redirect_to documents_index_path

	rescue Boxr::BoxrError => e
		@client.create_folder(@user_name, @parent_folder)
		redirect_to documents_index_path
	end
  end
end