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
