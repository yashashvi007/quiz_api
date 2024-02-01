class AddIsArchivedToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :is_archived, :boolean, default: false
  end
end
