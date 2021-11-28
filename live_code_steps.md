# Live code steps

### Setup
```shell
gco initial-branch
gcb live-code-ruby-summit
```

### Installation
Adds gem to Gemfile
```ruby
gem "scenic"
```

```shell
bundle
```

### First view, class students list with grade

```shell
rails g scenic:view class_students_list
```

Shows generated files(migration and empty sql file)

Adds first version of view to sql file
```sql
select
  courses.name as course_name,
  disciplines.name as discipline_name,
  teachers.name as teacher_name,
  course_classes.semester,
  course_classes.year,
  students.name as student_name,
  students.email as student_email
from students
inner join course_class_students on course_class_students.student_id = students.id
inner join course_classes on course_classes.id = course_class_students.course_class_id
inner join disciplines on disciplines.id = course_classes.discipline_id
inner join teachers on teachers.id = course_classes.teacher_id
inner join courses on courses.id = disciplines.course_id;
```

```shell
rails db:migrate
```

Shows schema with view added to the end of it

Generates a second version of the view
```shell
rails g scenic:view class_students_list
```

Shows generated files(migration for update and empty sql file)

Adds second version of view to sql file
```sql
select
  courses.name as course_name,
  disciplines.name as discipline_name,
  teachers.name as teacher_name,
  course_classes.semester,
  course_classes.year,
  students.name as student_name,
  students.email as student_email,
  course_class_students.grade as student_grade
from students
inner join course_class_students on course_class_students.student_id = students.id
inner join course_classes on course_classes.id = course_class_students.course_class_id
inner join disciplines on disciplines.id = course_classes.discipline_id
inner join teachers on teachers.id = course_classes.teacher_id
inner join courses on courses.id = disciplines.course_id
```

```shell
rails db:migrate
```

Shows schemas with updated view sql definition


### Second view, teachers statistics

```shell
rails g scenic:model teachers_statistics --materialized
```

Obs: for now the above materialized flag is not working, need to try again during the week first. Instead use the below command
```shell
rails g scenic:model teachers_statistics
```

Changes migration to add materialized flag
```ruby
  create_view :teachers_statistics, materialized: true
```

Changes model to add readonly and refresh methods
```ruby
  # this isn't strictly necessary, but it will prevent
  # rails from calling save, which would fail anyway.
  def readonly?
    true
  end

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end
```

Explain concurrently and cascade

Adds sql to generated sql file
```sql
select
  teachers.id as teacher_id,
  teachers.name as teacher_name,
  course_classes.semester,
  course_classes.year,
  avg(course_class_students.grade) as average_grade,
  count(distinct course_class_students.student_id) as total_students,
  count(distinct course_class_students.course_class_id) as total_classes
from teachers
inner join course_classes on teachers.id = course_classes.teacher_id
inner join course_class_students on course_classes.id = course_class_students.course_class_id
group by teachers.id, teachers.name, course_classes.semester, course_classes.year
```

Runs migration and shows schema after it
```shell
rails db:migrate
```

Opens rails console and runs the refresh method with concurrently false
```shell
rails c
```

```ruby
TeachersStatistic.refresh
```

Change model to concurrently true on refresh

Open rails console and try to run the refresh method
```shell
rails c
```

```ruby
TeachersStatistic.refresh
```

Creates migration to add index to the view
```shell
rails g migration add_index_to_teachers_statistics
```

Updates migration to add unique index
```ruby
add_index :teachers_statistics, %i[teacher_id semester year], unique: true
```

Runs migration
```shell
rails db:migrate
```

Open rails console and try to run the refresh method
```shell
rails c
```

```ruby
TeachersStatistic.refresh
```

Adds relationships and methods to mview model

```ruby
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
```
