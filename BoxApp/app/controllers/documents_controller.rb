require 'boxr'

class DocumentsController < ApplicationController
  def index
  	@documents = Document.all
  	client = Boxr::Client.new('qExAtRp4CM0uAMQ2ms3qng3bP7UJuuV5')
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

  		client = Boxr::Client.new('qExAtRp4CM0uAMQ2ms3qng3bP7UJuuV5')
		parentFolder = client.folder_from_path('/Uploaded Documents/Angel Lee')
		client.upload_file(docPath, parentFolder)
  		redirect_to documents_path, notice: "The document has been uploaded."
  	else
  		render "new"
  	end
  end

  def destroy
  	#@document = Document.find(params[:id])
  	@item = params[:item]

  	client = Boxr::Client.new('qExAtRp4CM0uAMQ2ms3qng3bP7UJuuV5')
	#client.delete_file(@item)
	puts @item

  	#@document.destroy
  	redirect_to documents_path, notice: "The document has been deleted."
  end

  def download
  	item = params[:item]

  	# client = Boxr::Client.new('qExAtRp4CM0uAMQ2ms3qng3bP7UJuuV5')
  	# client.download_file(@item_id)

  	begin
  		client = Boxr::Client.new('qExAtRp4CM0uAMQ2ms3qng3bP7UJuuV5')
  		client.download_file(@item_id)
  	rescue Boxr::BoxrError => e
  		puts e
  	end

  	redirect_to documents_path, notice: "The document has been downloaded."
  end

  private
  	def document_params
  	params.require(:document).permit(:name, :attachment)
  end
end
