class CreateAssesments < ActiveRecord::Migration[7.0]
  def change
    create_table :assesments do |t|
      t.string :title 
      t.integer :duration 
      t.integer :difficulty_level
      t.boolean :is_archived 
      t.time :scheduled_at
      t.timestamps
    end
  end
end
