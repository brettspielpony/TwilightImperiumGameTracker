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

ActiveRecord::Schema.define(version: 2020_02_29_093757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "uid", null: false
    t.string "name", null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.integer "victory_points", null: false
    t.string "map"
    t.string "aasm_state", default: "preparing", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "winner_id"
    t.jsonb "player_scores", default: {}, null: false
    t.integer "custodian_owner_id"
  end

  create_table "player_stats", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "round_id", null: false
    t.jsonb "scored_public_objectives", default: [], null: false
    t.jsonb "scored_secret_objectives", default: [], null: false
    t.jsonb "picked_strategy_cards", default: []
    t.index ["player_id"], name: "index_player_stats_on_player_id"
    t.index ["round_id"], name: "index_player_stats_on_round_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "uid", null: false
    t.string "name", null: false
    t.string "faction", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "technologies", default: [], null: false
    t.integer "seat_number", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "index", default: 1, null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "aasm_state", default: "strategy_phase", null: false
    t.jsonb "revealed_objectives", default: [], null: false
    t.integer "speaker_id", null: false
    t.jsonb "revealed_agenda_cards", default: [], null: false
    t.index ["game_id"], name: "index_rounds_on_game_id"
  end

  add_foreign_key "games", "players", column: "winner_id"
  add_foreign_key "player_stats", "players"
  add_foreign_key "player_stats", "rounds"
  add_foreign_key "players", "games"
  add_foreign_key "rounds", "games"
end
