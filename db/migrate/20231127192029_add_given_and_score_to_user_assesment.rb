class AddGivenAndScoreToUserAssesment < ActiveRecord::Migration[7.0]
  def change
    add_column :user_assesments , :attended, :boolean , :default => false
    add_column :user_assesments , :score , :integer 
  end
end
