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

ActiveRecord::Schema.define(version: 20160519221721) do

  create_table "matches", force: :cascade do |t|
    t.integer  "tournament_id",     limit: 4, null: false
    t.integer  "player1_id",        limit: 4, null: false
    t.integer  "player2_id",        limit: 4, null: false
    t.integer  "player1_games_won", limit: 4, null: false
    t.integer  "player2_games_won", limit: 4, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "matches", ["player1_id"], name: "index_matches_on_player1_id", using: :btree
  add_index "matches", ["player2_id"], name: "index_matches_on_player2_id", using: :btree
  add_index "matches", ["tournament_id"], name: "index_matches_on_tournament_id", using: :btree

  create_table "names", force: :cascade do |t|
    t.integer  "player_id",   limit: 4,   null: false
    t.string   "tag",         limit: 255, null: false
    t.boolean  "desired_tag",             null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "names", ["player_id"], name: "index_names_on_player_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.float    "skill",      limit: 24, default: 1200.0
    t.integer  "wins",       limit: 4,  default: 0
    t.integer  "losses",     limit: 4,  default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "title",             limit: 255,   null: false
    t.datetime "event_time",                      null: false
    t.text     "event_description", limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
