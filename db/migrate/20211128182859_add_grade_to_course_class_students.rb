class AddGradeToCourseClassStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :course_class_students, :grade, :decimal, default: 0.0, null: false
  end
end
