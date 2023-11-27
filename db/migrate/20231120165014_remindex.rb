class Remindex < ActiveRecord::Migration[7.0]
  def change
    remove_index :responses, :option
  end
end
