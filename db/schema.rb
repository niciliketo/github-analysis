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

ActiveRecord::Schema[7.0].define(version: 2020_01_11_194302) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pull_requests", force: :cascade do |t|
    t.integer "number"
    t.string "creator"
    t.string "merged_by"
    t.string "milestone"
    t.datetime "pr_created_at", precision: nil
    t.datetime "pr_merged_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "data"
    t.bigint "repo_id"
    t.index ["repo_id"], name: "index_pull_requests_on_repo_id"
  end

  create_table "reports", force: :cascade do |t|
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "full_name"
    t.boolean "public"
    t.text "data"
    t.datetime "checked_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_repos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.string "provider"
    t.string "uid"
    t.string "image"
    t.string "name"
    t.string "nickname"
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "pull_requests", "repos"
  add_foreign_key "repos", "users"
end
