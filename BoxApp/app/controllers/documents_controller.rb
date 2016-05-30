require 'boxr'

class DocumentsController < ApplicationController
  def index
  	@documents = Document.all
  	client = Boxr::Client.new('PLmOqa5ejaSjFjslpnvLbQjx48gFSAbp')
  	path = client.folder_from_path('/Uploaded Documents/Angel Lee')
  	@folderItems = client.folder_items(path)
  	@folderItems.each {|i| puts i.name}
  end

  def new
  	@document = Document.new
  end

  def create
  	@document = Document.new(document_params)

  	if @document.save
  		docPath = @document.attachment.current_path

  		client = Boxr::Client.new('PLmOqa5ejaSjFjslpnvLbQjx48gFSAbp')
		parentFolder = client.folder_from_path('/Uploaded Documents/Angel Lee')
		client.upload_file(docPath, parentFolder)
  		redirect_to documents_path, notice: "The document has been uploaded."
  	else
  		render "new"
  	end
  end

  def destroy
  	#@document = Document.find(params[:id])
  	@item = params[:type]

  	client = Boxr::Client.new('PLmOqa5ejaSjFjslpnvLbQjx48gFSAbp')
	  client.delete_file(@item['id'])

  	#@document.destroy
  	redirect_to documents_path, notice: "The document has been deleted."
  end

  def download
  	@item = params[:type]

  	# client = Boxr::Client.new('PBrQW2XuFQR3Oz1gWafvFgOnCgw3LpsO')
  	# client.download_file(@item_id)

  	client = Boxr::Client.new('PLmOqa5ejaSjFjslpnvLbQjx48gFSAbp')
    
  	client.download_file(@item['id'])

  	redirect_to documents_path, notice: "The document has been downloaded."
  end

  private
  	def document_params
  	params.require(:document).permit(:name, :attachment)
  end
end
