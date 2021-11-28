# README

This project was created to show some examples on how to work with views on rails projects using scenic

## Database Diagram

https://dbdiagram.io/d/61a2e20b8c901501c0d585c8

## Views

### Class students grades

```sql
select
  course.name,
  discipline.name,
  teachers.name,
  course_classes.semester,
  course_classes.year,
  students.name,
  students.email
from students
inner join course_class_students on course_class_students.student_id = students.id
inner join course_classes on course_classes.id = course_class_students.course_class_id
inner join disciplines on disciplines.id = course_classes.discipline_id
inner join teachers on teachers.id = course_classes.teacher_id
inner join courses on courses.id = disciplines.course_id
```

### Teacher's grade average per semester

```sql
select
  teachers.id,
  teachers.name,
  course_classes.semester,
  course_classes.year,
  avg(course_class_students.grade) as average_grade
from teachers
inner join course_classes on teachers.id = course_classes.teacher_id
inner join course_class_students on course_classes.id = course_class_students.course_class_id
group by teachers.id, teachers.name, course_classes.semester, course_classes.year
```

### Teachers's statistics per semester

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

### Course's demographics per semester

```sql
select
  courses.id as course_id,
  courses.name as course_name,
  course_classes.semester,
  course_classes.year,
  states.id as state_id,
  states.name as state_name,
  states.abbreviation as state_abbreviation,
  count(distinct cities.id) as total_cities,
  count(distinct students.id) as total_students
from courses
inner join disciplines on disciplines.course_id = courses.id
inner join course_classes on course_classes.discipline_id = disciplines.id
inner join course_class_students on course_class_students.course_class_id = course_classes.id
inner join students on students.id = course_class_students.student_id
inner join addresses on addresses.student_id = students.id
inner join cities on cities.id = addresses.city_id
inner join states on states.id = cities.state_id
group by courses.id, courses.name, states.id, course_classes.semester, course_classes.year, states.name, states.abbreviation;
```
