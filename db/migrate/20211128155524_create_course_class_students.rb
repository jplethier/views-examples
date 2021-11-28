class CreateCourseClassStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :course_class_students do |t|
      t.references :course_class, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
