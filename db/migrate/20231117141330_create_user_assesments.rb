class CreateUserAssesments < ActiveRecord::Migration[7.0]
  def change
    create_table :user_assesments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :assesment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
