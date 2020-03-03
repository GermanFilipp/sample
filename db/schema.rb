# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_02_165448) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.bigint "video_id"
    t.integer "attachment_type", default: 0, null: false
    t.string "file", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["video_id", "attachment_type"], name: "index_attachments_on_video_id_and_attachment_type", unique: true
    t.index ["video_id"], name: "index_attachments_on_video_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["digest"], name: "index_users_on_digest", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.integer "start_time", null: false
    t.integer "end_time", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

  add_foreign_key "videos", "users"
end
