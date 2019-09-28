class AddUserIdToStudies < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM studies;'
    add_reference :studies, :user, null: false, index: true
  end

  def down
    remove_reference :studies, user, index: true
  end
end
