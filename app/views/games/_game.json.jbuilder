json.extract! game, :id, :player_card, :dealer_card, :winner, :simulation_id, :created_at, :updated_at
json.url game_url(game, format: :json)
