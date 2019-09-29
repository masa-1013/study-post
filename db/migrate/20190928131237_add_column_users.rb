class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :public, :boolean, default: false
  end
end
