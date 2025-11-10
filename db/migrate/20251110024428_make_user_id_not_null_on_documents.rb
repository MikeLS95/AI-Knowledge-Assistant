class MakeUserIdNotNullOnDocuments < ActiveRecord::Migration[8.1]
  def change
    change_column_null :documents, :user_id, false
  end
end
