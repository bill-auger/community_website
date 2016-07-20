# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160720052159) do

  create_table "poll_options", force: :cascade do |t|
    t.string   "option"
    t.boolean  "is_other",   default: false
    t.integer  "poll_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "poll_options", ["poll_id"], name: "index_poll_options_on_poll_id"

  create_table "polls", force: :cascade do |t|
    t.string   "topic"
    t.boolean  "is_open",    default: true
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "polls", ["project_id"], name: "index_polls_on_project_id"
  add_index "polls", ["user_id"], name: "index_polls_on_user_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "repo",       default: ""
    t.text     "desc",       default: ""
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["name"], name: "index_projects_on_name", unique: true
  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "nick"
    t.string   "uid"
    t.string   "avatar",     default: ""
    t.string   "bio",        default: ""
    t.boolean  "is_admin",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["nick"], name: "index_users_on_nick", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "poll_id"
    t.integer  "poll_option_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["poll_id"], name: "index_votes_on_poll_id"
  add_index "votes", ["poll_option_id"], name: "index_votes_on_poll_option_id"
  add_index "votes", ["user_id", "poll_id"], name: "index_votes_on_user_id_and_poll_id", unique: true
  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

end
