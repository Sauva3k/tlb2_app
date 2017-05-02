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

ActiveRecord::Schema.define(version: 20170421150646) do

  create_table "connections", force: :cascade do |t|
    t.integer  "wifi_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_connections_on_user_id"
    t.index ["wifi_id", "user_id"], name: "index_connections_on_wifi_id_and_user_id", unique: true
    t.index ["wifi_id"], name: "index_connections_on_wifi_id"
  end

  create_table "task_items", force: :cascade do |t|
    t.text     "description"
    t.integer  "points"
    t.integer  "user_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "approval_required", default: false
    t.index ["user_id", "created_at"], name: "index_task_items_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_task_items_on_user_id"
  end

  create_table "todo_items", force: :cascade do |t|
    t.string   "content"
    t.integer  "todo_list_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "completed_at"
    t.index ["todo_list_id"], name: "index_todo_items_on_todo_list_id"
  end

  create_table "todo_lists", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "points"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "username"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "wifis", force: :cascade do |t|
    t.string   "key"
    t.string   "name"
    t.boolean  "status",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
