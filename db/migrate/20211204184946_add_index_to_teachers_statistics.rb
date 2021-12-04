class AddIndexToTeachersStatistics < ActiveRecord::Migration[6.1]
  def change
    add_index :teachers_statistics, %i[teacher_id semester year], unique: true
  end
end
