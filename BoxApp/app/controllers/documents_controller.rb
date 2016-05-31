require 'boxr'
require 'open-uri'

class DocumentsController < ApplicationController
  before_filter :get_client

  # get the client, sets root folder
  def get_client
    @client = Boxr::Client.new('OIKx5i9kZTKwlVeBcHATgUdyqmYqVkPR')
    # @client = params[:client]
    # puts 'Hi'  
    # puts @client 
    @home_folder_name = '/Uploaded Documents/'
    @parent_folder = @client.folder_from_path(@home_folder_name)
    @user_name = @client.current_user.name
    @user_folder_name = @home_folder_name + @user_name
  end

  # displays items in the user's folder
  def index
  	# @documents = Document.all
    # @client = params[:type]
  	path = @client.folder_from_path(@user_folder_name)
  	@folder_items = @client.folder_items(path)
    # @folderItems = @client.folder_items(@userFolder)
  	@folder_items.each {|i| puts i.name}
  end

  def new
  	@document = Document.new
  end

  # upload a new document
  def create
  	@document = Document.new(document_params)
    # @client = params[:type]

    begin
      doc_path = @document.attachment.current_path
      user_folder = @client.folder_from_path(@user_folder_name)
      @client.upload_file(doc_path, user_folder)
      redirect_to documents_path, notice: "The document has been uploaded."
    rescue Boxr::BoxrError => e
      # render "new"
      redirect_to documents_path, alert: "The document could not be uploaded."
    end
  end

  # delete a document
  def destroy
  	#@document = Document.find(params[:id])
  	@item = params[:type]
    # @client = params[:type]
	  @client.delete_file(@item['id'])

  	#@document.destroy
  	redirect_to documents_path, notice: "The document has been deleted."
  end

  # download a document
  def download
  	@item = params[:type]
    # @client = params[:type]

  	file = @client.download_file(@item['id'])

    downloads_directory = Dir.home + "/Downloads"

    f = File.open("#{downloads_directory}/#{@item['name']}", 'wb')
      f.write(file)
      f.close

  	redirect_to documents_path, notice: "The document has been downloaded."
  end

  # view a document
  def preview
    @item = params[:type]
    url = @client.embed_url(@item['id'])

    puts url
  end

  private
  	def document_params
  	params.require(:document).permit(:attachment)
  end
end
