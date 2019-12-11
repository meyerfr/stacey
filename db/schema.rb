# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_09_133338) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amenities", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "project_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_amenities_on_project_id"
    t.index ["room_id"], name: "index_amenities_on_room_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "room_id"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_bookings_on_room_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "booking_id"
    t.binary "signature"
    t.date "signed_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_contracts_on_booking_id"
  end

  create_table "icons", force: :cascade do |t|
    t.string "icon_text"
    t.bigint "amenity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amenity_id"], name: "index_icons_on_amenity_id"
  end

  create_table "partners", force: :cascade do |t|
    t.string "name"
    t.string "company"
    t.string "email"
    t.string "phone_code"
    t.string "phone"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "street"
    t.string "house_number"
    t.string "city"
    t.integer "zipcode"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "pictures"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "project_id"
    t.string "number"
    t.string "house_number"
    t.float "price", default: [], array: true
    t.string "name"
    t.float "size"
    t.text "description"
    t.json "pictures"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_rooms_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.string "street"
    t.string "city"
    t.integer "zipcode"
    t.string "country"
    t.date "move_in"
    t.date "move_out"
    t.string "instagram"
    t.string "facebook"
    t.string "twitter"
    t.string "linkedin"
    t.string "job"
    t.integer "amount_of_people", default: 1
    t.string "gender"
    t.string "prefered_suite", default: [], array: true
    t.string "phone_number"
    t.string "phone_code"
    t.string "photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "welcome_calls", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "user_id"
    t.boolean "available", default: true
    t.index ["user_id"], name: "index_welcome_calls_on_user_id"
  end

  add_foreign_key "amenities", "projects"
  add_foreign_key "amenities", "rooms"
  add_foreign_key "bookings", "rooms"
  add_foreign_key "bookings", "users"
  add_foreign_key "contracts", "bookings"
  add_foreign_key "icons", "amenities"
  add_foreign_key "rooms", "projects"
  add_foreign_key "welcome_calls", "users"
end
