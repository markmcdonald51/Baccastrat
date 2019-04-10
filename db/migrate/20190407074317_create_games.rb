class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :player_cards
      t.integer :player_score
      t.string :banker_cards
      t.integer :banker_score
      t.string :winner, index: true 
      t.references :simulation, foreign_key: true

      #t.timestamps
    end
  end
end
