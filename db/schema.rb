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

ActiveRecord::Schema.define(version: 2022_01_13_052659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_mailbox_inbound_emails", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "message_id", null: false
    t.string "message_checksum", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id", "message_checksum"], name: "index_action_mailbox_inbound_emails_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "password_digest"
    t.string "course_list", default: ["CS10", "CS61A", "CS61B", "CS61C", "CS70", "CS88", "EE16A", "EE16B", "DATA8", "UPPERDIV"], array: true
    t.text "tutor_types", default: "CSM (8-10 hours)\r\nTA (12 hours)\r\nAcademic Intern (36 hours)\r\nTutor (12 hours)"
    t.string "priority_list", default: [], array: true
    t.string "tutor_list", default: [], array: true
    t.boolean "signups_allowed", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.bigint "meeting_id"
    t.boolean "took_place"
    t.string "course"
    t.decimal "hours"
    t.string "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_evaluations_on_meeting_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "tutor_id"
    t.bigint "request_id"
    t.datetime "set_time"
    t.string "set_location"
    t.string "status", default: "unscheduled"
    t.json "meta_values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_meetings_on_request_id"
    t.index ["tutor_id"], name: "index_meetings_on_tutor_id"
  end

  create_table "question_templates", force: :cascade do |t|
    t.integer "order"
    t.string "prompt", default: "Your Prompt Here"
    t.boolean "is_optional", default: false
    t.string "question_type", default: "text"
    t.boolean "is_active", default: true
    t.boolean "is_admin_only", default: false
    t.json "details", default: {"min_char"=>50, "options"=>"Your Options Here", "min_val"=>1, "min_lab"=>"Poor", "max_val"=>7, "max_lab"=>"Great"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "question_template_id"
    t.bigint "evaluation_id"
    t.string "prompt"
    t.text "response"
    t.boolean "is_admin_only"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_questions_on_evaluation_id"
    t.index ["question_template_id"], name: "index_questions_on_question_template_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "user_id"
    t.string "course"
    t.decimal "meeting_length"
    t.string "subject"
    t.string "status", default: "open"
    t.json "meta_values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "type", default: "Tutee"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.string "pronoun"
    t.string "ethnicity", array: true
    t.string "major"
    t.boolean "dsp"
    t.boolean "transfer"
    t.string "term"
    t.boolean "has_priority", default: false
    t.json "meta_values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "evaluations", "meetings"
  add_foreign_key "meetings", "requests"
  add_foreign_key "meetings", "users", column: "tutor_id"
  add_foreign_key "questions", "evaluations"
  add_foreign_key "questions", "question_templates"
  add_foreign_key "requests", "users"
end
