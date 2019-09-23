class CreateStudies < ActiveRecord::Migration[5.2]
  def change
    create_table :studies do |t|
      t.string :title, limit: 30
      t.text :content, limit: 256
      t.time :time, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
