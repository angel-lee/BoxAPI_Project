require 'boxr'

class WelcomeController < ApplicationController
	def index
		client = Boxr::Client.new('WAc0TS4xzeaRWFcO74TOnI6F23rdPR5b')
		items = client.folder_items(Boxr::ROOT)
		items.each {|i| puts i.name}
	end
	helper_method :hi

	def create
		client = Boxr::Client.new('WAc0TS4xzeaRWFcO74TOnI6F23rdPR5b')
		folder = client.folder_from_path('/Uploaded Documents')
		client.create_folder('Folder', folder)
	end
end
