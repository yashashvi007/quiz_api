class CreateJoinTableQuestionTag < ActiveRecord::Migration[7.0]
  def change
    create_join_table :questions, :tags do |t|
      t.index [:question_id, :tag_id]
      # t.index [:tag_id, :question_id]
    end
  end
end
