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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130602034812) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "obsessions", :force => true do |t|
    t.string  "nameid"
    t.string  "word"
    t.integer "count"
    t.string  "yearmonth"
  end

  add_index "obsessions", ["nameid", "word", "yearmonth"], :name => "index_obsessions_on_nameid_and_word_and_yearmonth", :unique => true

  create_table "session_talkers", :force => true do |t|
    t.integer  "session_id"
    t.datetime "ts"
    t.string   "name"
    t.string   "nameid"
    t.string   "electorate"
    t.string   "party"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.date     "date"
    t.integer  "parliamentno"
    t.integer  "sessionno"
    t.integer  "periodno"
    t.string   "chamber"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "speeches", :force => true do |t|
    t.integer  "session_talker_id"
    t.text     "speech"
    t.datetime "time"
    t.string   "nameid"
  end

end
