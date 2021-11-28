# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_28_195915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.string "street", null: false
    t.string "number"
    t.bigint "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_addresses_on_city_id"
    t.index ["student_id"], name: "index_addresses_on_student_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.bigint "state_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "course_class_students", force: :cascade do |t|
    t.bigint "course_class_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "grade", default: "0.0", null: false
    t.index ["course_class_id"], name: "index_course_class_students_on_course_class_id"
    t.index ["student_id"], name: "index_course_class_students_on_student_id"
  end

  create_table "course_classes", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.integer "year"
    t.integer "semester"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "discipline_id"
    t.index ["discipline_id"], name: "index_course_classes_on_discipline_id"
    t.index ["teacher_id"], name: "index_course_classes_on_teacher_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "disciplines", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_disciplines_on_course_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_students_on_email", unique: true
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "students"
  add_foreign_key "cities", "states"
  add_foreign_key "course_class_students", "course_classes"
  add_foreign_key "course_class_students", "students"
  add_foreign_key "course_classes", "disciplines"
  add_foreign_key "course_classes", "teachers"
  add_foreign_key "disciplines", "courses"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "students"

  create_view "class_students_lists", sql_definition: <<-SQL
      SELECT courses.name AS course_name,
      disciplines.name AS discipline_name,
      teachers.name AS teacher_name,
      course_classes.semester,
      course_classes.year,
      students.name AS student_name,
      students.email AS student_email,
      course_class_students.grade AS student_grade
     FROM (((((students
       JOIN course_class_students ON ((course_class_students.student_id = students.id)))
       JOIN course_classes ON ((course_classes.id = course_class_students.course_class_id)))
       JOIN disciplines ON ((disciplines.id = course_classes.discipline_id)))
       JOIN teachers ON ((teachers.id = course_classes.teacher_id)))
       JOIN courses ON ((courses.id = disciplines.course_id)));
  SQL
end
