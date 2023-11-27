class AddAssesmentIdToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :assesment, foreign_key: true
  end
end
