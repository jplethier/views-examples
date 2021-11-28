class ChangeReferencesOnCourseClasses < ActiveRecord::Migration[6.1]
  def change
    remove_reference :course_classes, :course, foreign_key: true
    add_reference :course_classes, :discipline, foreign_key: true
  end
end
