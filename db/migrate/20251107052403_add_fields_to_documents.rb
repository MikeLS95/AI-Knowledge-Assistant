class AddFieldsToDocuments < ActiveRecord::Migration[8.1]
  def change
    add_column :documents, :title, :string
    add_column :documents, :content, :text
  end
end
