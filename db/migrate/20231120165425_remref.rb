class Remref < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :responses, :options
  end
end
