class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :player_cards
      t.integer :player_score
      t.string :banker_cards
      t.integer :banker_score
      t.integer :bet_amount, default: 0
      t.integer :bet_units, default: 0
      t.string :bet_position
      t.string :bet_result
      t.string :winner, index: true 
      t.integer :bet_aim_count
      t.references :simulation, foreign_key: true

      #t.timestamps
    end
  end
end
