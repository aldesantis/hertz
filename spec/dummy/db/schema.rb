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

ActiveRecord::Schema.define(version: 2019_09_10_164850) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "hertz_deliveries", id: :serial, force: :cascade do |t|
    t.integer "notification_id", null: false
    t.string "courier", null: false
    t.datetime "created_at", null: false
    t.index ["notification_id", "courier"], name: "index_hertz_notification_deliveries_on_notification_and_courier", unique: true
    t.index ["notification_id"], name: "index_hertz_deliveries_on_notification_id"
  end

  create_table "hertz_notifications", id: :serial, force: :cascade do |t|
    t.string "type", null: false
    t.string "receiver_type", null: false
    t.integer "receiver_id", null: false
    t.hstore "meta", default: {}, null: false
    t.datetime "read_at"
    t.datetime "created_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "hertz_deliveries", "hertz_notifications", column: "notification_id", on_delete: :cascade
end
