require 'boxr'

class DocumentsController < ApplicationController
  before_filter :get_client

  # get the client, sets root folder
  def get_client
    @client = Boxr::Client.new('DEV_TOKEN') # put Dev Token here
    
    @home_folder_name = '/Uploaded Documents/'
    @parent_folder = @client.folder_from_path(@home_folder_name)
    @user_name = @client.current_user.name
    @user_folder_name = @home_folder_name + @user_name
  end

  # displays items in the user's folder
  def index
    path = @client.folder_from_path(@user_folder_name)
    @folder_items = @client.folder_items(path)
    @folder_items.each {|i| puts i.name}
  end

  def new
    @document = Document.new
  end

  # upload a new document
  def create
    @document = Document.new(document_params)

    begin
      doc_path = @document.attachment.current_path
      user_folder = @client.folder_from_path(@user_folder_name)
      @client.upload_file(doc_path, user_folder)
      redirect_to documents_path, notice: "The document has been uploaded."
    rescue Boxr::BoxrError => e
      redirect_to documents_path, alert: "The document could not be uploaded."
    end
  end

  # delete a document
  def destroy
    #@document = Document.find(params[:id])
    @item = params[:type]
    @client.delete_file(@item['id'])
    #@document.destroy
    redirect_to documents_path, notice: "The document has been deleted."
  end

  # download a document
  def download
    @item = params[:type]

    file = @client.download_file(@item['id'])
    f = File.open("./#{@item['name']}", 'wb')
    f.write(file)
    f.close

    send_data file, :disposition => 'attachment', :filename=>"#{@item['name']}"

    File.delete("./#{@item['name']}")
  end

  # view a document
  def preview
    @item = params[:type]
    @preview_url = @client.embed_url(@item['id'])
  end

  def redirect
    redirect_to documents_path
  end

  private
    def document_params
    params.require(:document).permit(:attachment)
  end
end
