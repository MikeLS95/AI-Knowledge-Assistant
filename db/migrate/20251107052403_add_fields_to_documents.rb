class AddFieldsToDocuments < ActiveRecord::Migration[8.1]
  def change
    add_column :documents, :title, :string unless column_exists?(:documents, :title)
    add_column :documents, :content, :text unless column_exists?(:documents, :content)
  end
end
