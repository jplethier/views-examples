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
