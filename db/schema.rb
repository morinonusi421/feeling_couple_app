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

ActiveRecord::Schema[7.0].define(version: 2023_12_12_081039) do
  create_table "likes", force: :cascade do |t|
    t.integer "liker_id"
    t.integer "liked_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["liked_id"], name: "index_likes_on_liked_id"
    t.index ["liker_id", "liked_id"], name: "index_likes_on_liker_id_and_liked_id", unique: true
    t.index ["liker_id"], name: "index_likes_on_liker_id"
  end

  create_table "parties", force: :cascade do |t|
    t.string "name"
    t.boolean "allow_like"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["name"], name: "index_parties_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "sex"
    t.boolean "has_choosed", default: false
    t.integer "loving_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "party_id"
    t.index ["loving_id"], name: "index_users_on_loving_id"
  end

  add_foreign_key "users", "users", column: "loving_id"
end
