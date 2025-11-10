class AddUserIdToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_reference :documents, :user, null: false, foreign_key: true
    add_index :documents, :user_id, :created_at
  end
end
