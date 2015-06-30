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

ActiveRecord::Schema.define(version: 20150630085543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commit_fixes", force: true do |t|
    t.integer  "fixing_commit_id"
    t.integer  "fixed_commit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commit_fixes", ["fixed_commit_id"], name: "index_commit_fixes_on_fixed_commit_id", using: :btree
  add_index "commit_fixes", ["fixing_commit_id", "fixed_commit_id"], name: "index_commit_fixes_on_fixing_commit_id_and_fixed_commit_id", unique: true, using: :btree
  add_index "commit_fixes", ["fixing_commit_id"], name: "index_commit_fixes_on_fixing_commit_id", using: :btree

  create_table "commits", force: true do |t|
    t.string   "remote_id"
    t.text     "message"
    t.string   "url"
    t.string   "state"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "passed_at"
    t.integer  "author_id"
    t.datetime "expires_at"
    t.datetime "authored_at"
    t.integer  "reviewer_id"
    t.string   "project_mongo_id"
    t.string   "user_mongo_id"
    t.string   "author_email"
  end

  add_index "commits", ["author_id"], name: "index_commits_on_author_id", using: :btree
  add_index "commits", ["project_id"], name: "index_commits_on_project_id", using: :btree
  add_index "commits", ["reviewer_id"], name: "index_commits_on_reviewer_id", using: :btree

  create_table "commits_tickets", id: false, force: true do |t|
    t.integer "commit_id"
    t.integer "ticket_id"
  end

  add_index "commits_tickets", ["commit_id", "ticket_id"], name: "index_commits_tickets_on_commit_id_and_ticket_id", using: :btree

  create_table "people", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commit_mongo_id"
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true, using: :btree

  create_table "permissions", force: true do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.boolean "allowed",          default: false
    t.string  "mongo_id"
    t.string  "old_level"
    t.string  "project_mongo_id"
    t.string  "user_mongo_id"
  end

  add_index "permissions", ["project_id", "user_id"], name: "index_permissions_on_project_id_and_user_id", unique: true, using: :btree
  add_index "permissions", ["project_id"], name: "index_permissions_on_project_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

  create_table "project_owners", force: true do |t|
    t.string   "name",       null: false
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string  "name"
    t.string  "url",              default: ""
    t.integer "trade_details",    default: 0,  null: false
    t.integer "project_owner_id"
    t.string  "mongo_id"
  end

  create_table "tickets", force: true do |t|
    t.string "remote_id"
    t.string "url"
    t.string "source"
  end

  create_table "tokens", force: true do |t|
    t.string  "value"
    t.string  "tokenable_type"
    t.integer "tokenable_id"
    t.string  "mongo_id"
    t.string  "tokenable_mongo_id"
  end

  add_index "tokens", ["tokenable_id", "tokenable_type"], name: "index_tokens_on_tokenable_id_and_tokenable_type", unique: true, using: :btree
  add_index "tokens", ["value"], name: "index_tokens_on_value", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string  "nickname"
    t.string  "email"
    t.string  "name"
    t.string  "image_url"
    t.string  "remote_uid"
    t.string  "provider"
    t.boolean "admin",      default: false
    t.integer "person_id"
    t.string  "mongo_id"
  end

end
