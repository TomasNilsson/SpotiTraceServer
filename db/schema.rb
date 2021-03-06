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

ActiveRecord::Schema.define(version: 20150303202032) do

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["latitude", "longitude"], name: "index_locations_on_latitude_and_longitude"
  add_index "locations", ["user_id"], name: "index_locations_on_user_id"

  create_table "songs", force: true do |t|
    t.string   "name"
    t.string   "artist"
    t.string   "uri"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "songs", ["user_id"], name: "index_songs_on_user_id"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "master_user_id"
  end

  add_index "users", ["master_user_id"], name: "index_users_on_master_user_id"

end
