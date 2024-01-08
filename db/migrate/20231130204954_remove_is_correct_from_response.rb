class RemoveIsCorrectFromResponse < ActiveRecord::Migration[7.0]
  def change
    remove_column :responses, :is_correct, :boolean
  end
end
