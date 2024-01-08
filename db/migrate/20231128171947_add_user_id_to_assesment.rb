class AddUserIdToAssesment < ActiveRecord::Migration[7.0]
  def change
    add_column :assesments, :user_id, :integer
  end
end
