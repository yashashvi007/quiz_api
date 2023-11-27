class AddQuestionIdToOption < ActiveRecord::Migration[7.0]
  def change
    add_reference :options , :question , foreign_key: true 
  end
end
