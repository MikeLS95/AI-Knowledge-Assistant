class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: [:show, :download, :destroy]
  before_action :authorize_user!, only: [:show, :download, :destroy]

  def index
    @documents = current_user.documents.order(created_at: :desc)
  end

  def new
    @document = current_user.documents.build
  end

  def create
    @document = current_user.documents.build(document_params)

    if @document.save
      redirect_to documents_path, notice: 'Document uploaded successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def download
    send_attachment_download_headers(@document.file, @document.title)
  end

  def destroy
    @document.destroy
    redirect_to documents_path, notice: 'Document deleted successfully.'
  end

  private

  def document_params
    params.require(:document).permit(:title, :file)
  end

  def set_document
    @document = Document.find(params[:id])
  end

  def authorize_user!
    redirect_to documents_path, alert: 'Not authorized.' unless @document.user == current_user
  end

  def send_attachment_download_headers(attachment, filename)
    send_data(
      attachment.download,
      filename: filename,
      type: attachment.content_type
    )
  end
end