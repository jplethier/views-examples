class CreateClassStudentsLists < ActiveRecord::Migration[6.1]
  def change
    create_view :class_students_lists
  end
end
