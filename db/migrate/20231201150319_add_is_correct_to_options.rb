class AddIsCorrectToOptions < ActiveRecord::Migration[7.0]
  def change
    add_column :options, :is_correct, :boolean
  end
end
