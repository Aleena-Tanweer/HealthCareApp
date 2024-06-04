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

ActiveRecord::Schema[7.1].define(version: 2024_06_04_062437) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doctors", force: :cascade do |t|
    t.string "specialization"
    t.string "clinic_hospital_name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_doctors_on_user_id"
  end

  create_table "lab_staffs", force: :cascade do |t|
    t.string "department"
    t.bigint "lab_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lab_id"], name: "index_lab_staffs_on_lab_id"
    t.index ["user_id"], name: "index_lab_staffs_on_user_id"
  end

  create_table "labs", force: :cascade do |t|
    t.string "name"
    t.string "country_code", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "doctor_id", null: false
    t.string "status"
    t.date "order_date"
    t.string "order_barcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lab_id", null: false
    t.index ["doctor_id"], name: "index_orders_on_doctor_id"
    t.index ["lab_id"], name: "index_orders_on_lab_id"
    t.index ["patient_id"], name: "index_orders_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.date "date_of_birth"
    t.string "address"
    t.string "contact_number"
    t.boolean "fasting_requirements"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "riders", force: :cascade do |t|
    t.string "vehicle_type"
    t.string "area_of_coverage"
    t.bigint "lab_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lab_id"], name: "index_riders_on_lab_id"
    t.index ["user_id"], name: "index_riders_on_user_id"
  end

  create_table "tests", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "name"
    t.text "description"
    t.boolean "fasting_required"
    t.string "status"
    t.date "sample_collection_date"
    t.date "sample_received_date"
    t.string "result_document"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_tests_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "role"
    t.string "jti", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "otp_secret_key"
    t.boolean "otp_required_for_login"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "doctors", "users"
  add_foreign_key "lab_staffs", "labs"
  add_foreign_key "lab_staffs", "users"
  add_foreign_key "orders", "doctors"
  add_foreign_key "orders", "labs"
  add_foreign_key "orders", "patients"
  add_foreign_key "patients", "users"
  add_foreign_key "riders", "labs"
  add_foreign_key "riders", "users"
  add_foreign_key "tests", "orders"
end
