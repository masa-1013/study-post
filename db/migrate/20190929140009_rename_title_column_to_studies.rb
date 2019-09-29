class RenameTitleColumnToStudies < ActiveRecord::Migration[5.2]
  def change
    rename_column :studies, :title, :tag
  end
end
