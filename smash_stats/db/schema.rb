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

ActiveRecord::Schema.define(version: 20161022185214) do

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

  create_table "news", force: :cascade do |t|
    t.string   "headline",   limit: 255,   null: false
    t.text     "body",       limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "players", force: :cascade do |t|
    t.float    "skill",                   limit: 24, default: 1500.0
    t.integer  "wins",                    limit: 4,  default: 0
    t.integer  "losses",                  limit: 4,  default: 0
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.float    "volatility",              limit: 24, default: 0.06
    t.float    "rating_deviation",        limit: 24, default: 350.0
    t.float    "season_volatility",       limit: 24, default: 0.06
    t.float    "season_rating_deviation", limit: 24, default: 350.0
    t.float    "season_skill",            limit: 24, default: 1500.0
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "title",             limit: 255,   null: false
    t.datetime "event_time",                      null: false
    t.text     "event_description", limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
