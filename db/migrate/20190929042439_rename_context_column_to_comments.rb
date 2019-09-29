class RenameContextColumnToComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :context, :content
  end
end
