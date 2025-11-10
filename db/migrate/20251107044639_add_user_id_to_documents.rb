class AddUserIdToDocuments < ActiveRecord::Migration[8.1]
  def change
    add_reference :documents, :user, null: true, foreign_key: true
    add_index :documents, :user_id, :created_at
  end
end
