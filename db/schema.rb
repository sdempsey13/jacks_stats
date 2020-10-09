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

ActiveRecord::Schema.define(version: 2020_10_02_212627) do

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.string "position"
    t.integer "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "nhl_id"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "skater_stats", force: :cascade do |t|
    t.string "season_year"
    t.string "season_type"
    t.integer "time_on_ice"
    t.integer "assists"
    t.integer "goals"
    t.integer "pim"
    t.integer "shots"
    t.integer "games"
    t.integer "hits"
    t.integer "power_play_goals"
    t.integer "power_play_points"
    t.integer "power_play_time_on_ice"
    t.integer "even_time_on_ice"
    t.float "faceoff_pct"
    t.float "shot_pct"
    t.integer "overtime_goals"
    t.integer "game_winning_goals"
    t.integer "short_handed_goal"
    t.integer "short_handed_points"
    t.integer "short_handed_time_on_ice"
    t.integer "blocked_shots"
    t.integer "plus_minus"
    t.integer "points"
    t.integer "shifts"
    t.integer "time_on_ice_per_game"
    t.integer "even_time_on_ice_per_game"
    t.integer "short_handed_time_on_ice_per_game"
    t.integer "power_play_time_on_ice_per_game"
    t.integer "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_skater_stats_on_player_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "nhl_id"
  end

  add_foreign_key "players", "teams"
  add_foreign_key "skater_stats", "players"
end
