class CreateCourseClasses < ActiveRecord::Migration[6.1]
  def change
    create_table :course_classes do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.integer :year
      t.integer :semester

      t.timestamps
    end
  end
end
