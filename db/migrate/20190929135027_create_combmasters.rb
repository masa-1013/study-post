class CreateCombmasters < ActiveRecord::Migration[5.2]
  def change
    create_table :combmasters do |t|
      t.string :tag_name, null: false

      t.timestamps
    end
  end
end
