class ChangeScheduledAtTypeInAssesment < ActiveRecord::Migration[7.0]
  def change
    change_column :assesments, :scheduled_at, :datetime
  end
end
