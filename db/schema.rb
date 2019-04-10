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

ActiveRecord::Schema.define(version: 2019_04_08_124016) do

  create_table "games", force: :cascade do |t|
    t.string "player_cards"
    t.integer "player_score"
    t.string "banker_cards"
    t.integer "banker_score"
    t.string "winner"
    t.integer "simulation_id"
    t.index ["simulation_id"], name: "index_games_on_simulation_id"
    t.index ["winner"], name: "index_games_on_winner"
  end

  create_table "simulations", force: :cascade do |t|
    t.integer "strategy_id"
    t.integer "unit_cost"
    t.integer "bankroll_start"
    t.integer "current_bankroll"
    t.integer "number_of_decks_in_shoe", default: 6
    t.string "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["strategy_id"], name: "index_simulations_on_strategy_id"
  end

  create_table "strategies", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "martingale", default: 0
    t.text "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "strategy_simulations", force: :cascade do |t|
    t.integer "strategy_id"
    t.integer "simulation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["simulation_id"], name: "index_strategy_simulations_on_simulation_id"
    t.index ["strategy_id"], name: "index_strategy_simulations_on_strategy_id"
  end

end
