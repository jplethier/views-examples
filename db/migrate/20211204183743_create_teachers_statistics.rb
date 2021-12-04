class CreateTeachersStatistics < ActiveRecord::Migration[6.1]
  def change
    create_view :teachers_statistics, materialized: true
  end
end
