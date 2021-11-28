class TeachersStatistic < ApplicationRecord
  belongs_to :teacher

  # this isn't strictly necessary, but it will prevent
  # rails from calling save, which would fail anyway.
  def readonly?
    true
  end

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: true, cascade: false)
  end

  def students_full?
    total_students > 50
  end

  def classes_full?
    total_classes > 3
  end
end
