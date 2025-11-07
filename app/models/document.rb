class User < ApplicationRecord
  has_many :documents, dependent: :destroy
end

# app/models/document.rb
class Document < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  validates :title, presence: true
  validates :file, presence: true
  validate :file_content_type

  # Automatically extract text content after file is attached
  after_create_commit :extract_content

  ALLOWED_CONTENT_TYPES = %w[
    application/pdf
    text/plain
    application/vnd.openxmlformats-officedocument.wordprocessingml.document
  ].freeze

  ALLOWED_EXTENSIONS = %w[pdf txt docx].freeze

  private

  def file_content_type
    return unless file.attached?

    unless ALLOWED_CONTENT_TYPES.include?(file.content_type)
      errors.add(:file, "must be a PDF, TXT, or DOCX file")
    end
  end

  def extract_content
    return unless file.attached?

    self.content = case file.content_type
                   when 'application/pdf'
                     extract_pdf_content
                   when 'text/plain'
                     extract_text_content
                   when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
                     extract_docx_content
                   end

    save if content.present?
  end

  def extract_pdf_content
    require 'pdf/reader'

    file.open do |temp_file|
      reader = PDF::Reader.new(temp_file)
      text = reader.pages.map { |page| page.text }.join("\n")
      text.strip
    end
  rescue => e
    Rails.logger.error("PDF extraction error: #{e.message}")
    ""
  end

  def extract_text_content
    file.download.force_encoding('UTF-8')
  rescue => e
    Rails.logger.error("Text extraction error: #{e.message}")
    ""
  end

  def extract_docx_content
    require 'docx'

    file.open do |temp_file|
      doc = Docx::Document.open(temp_file)
      doc.paragraphs.map(&:text).join("\n").strip
    end
  rescue => e
    Rails.logger.error("DOCX extraction error: #{e.message}")
    ""
  end
end