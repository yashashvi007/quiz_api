class ChangeOptionTypeToIntegerInQuestion < ActiveRecord::Migration[7.0]
  def change
    change_column :questions, :correct_answer, :integer , array: true
  end
end
