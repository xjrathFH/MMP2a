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

ActiveRecord::Schema[7.1].define(version: 2024_02_08_195738) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.string "title", null: false
    t.string "description"
    t.float "minimum_fee", null: false
    t.boolean "public", null: false
    t.boolean "outcome"
    t.string "winning_condition", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "resolved"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "bet_id", null: false
    t.string "message", limit: 255, null: false
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "didwin"
    t.index ["bet_id"], name: "index_notifications_on_bet_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "participations", force: :cascade do |t|
    t.integer "bet_id"
    t.integer "owner_id"
    t.integer "fee", null: false
    t.string "message"
    t.boolean "anonymous", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "outcome"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "access_token"
    t.datetime "token_expires_at"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "status"
    t.string "department"
    t.string "studies"
    t.boolean "is_admin"
    t.float "balance"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bets", "users", column: "owner_id"
  add_foreign_key "notifications", "bets"
  add_foreign_key "notifications", "users"
  add_foreign_key "participations", "bets"
  add_foreign_key "participations", "users", column: "owner_id"
end
