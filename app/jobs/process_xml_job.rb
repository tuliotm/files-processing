class ProcessXmlJob < ApplicationJob
  queue_as :default

  def perform(document_id)
    document = ActiveStorage::Blob.find_signed(document_id)
    parsed_data = parse_xml(document.download)
  end

  private

  def parse_xml(xml_data)
    Nokogiri::XML(xml_data)
  end
end
