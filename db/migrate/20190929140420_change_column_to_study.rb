class ChangeColumnToStudy < ActiveRecord::Migration[5.2]
  def up
    change_column :studies, :tag, :string, null: false, limit:3
  end

  def down
    change_column :studies, :tag, :string, limit: 30
  end
end
