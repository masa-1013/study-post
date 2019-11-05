class ChangeDatatypeTagOfStudies < ActiveRecord::Migration[5.2]
  def change
    change_column :studies, :tag, "integer USING CAST(tag AS integer)"
  end
end
