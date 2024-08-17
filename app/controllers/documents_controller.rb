class DocumentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @documents = current_user.documents

    render new_document_path
  end

  def new
    @document = current_user.documents.build
  end

  def show
    @document = current_user.documents.find(params[:id])
    @parsed_data = parse_xml(@document.download)
  end

  def create
    if params[:document].present?
      params[:document].each do |doc|
        attached_file = current_user.documents.attach(doc).first
        ProcessXmlJob.perform_later(attached_file.signed_id) if attached_file.present?
      end
      redirect_to documents_path, notice: 'Documentos enviados com sucesso!'
    else
      render :new
    end
  end

  private

  def parse_xml(xml_data)
    doc = Nokogiri::XML(xml_data)
  end
end
