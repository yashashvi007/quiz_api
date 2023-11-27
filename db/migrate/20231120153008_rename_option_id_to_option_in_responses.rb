class RenameOptionIdToOptionInResponses < ActiveRecord::Migration[7.0]
  def change
    rename_column :responses, :option_id, :option
  end
end
