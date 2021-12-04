class UpdateClassStudentsListsToVersion2 < ActiveRecord::Migration[6.1]
  def change
    update_view :class_students_lists, version: 2, revert_to_version: 1
  end
end
