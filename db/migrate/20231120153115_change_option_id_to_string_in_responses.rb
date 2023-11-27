class ChangeOptionIdToStringInResponses < ActiveRecord::Migration[7.0]
  def change
    change_column :responses , :option , :string 
  end
end
