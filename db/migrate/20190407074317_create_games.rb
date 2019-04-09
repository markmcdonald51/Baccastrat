class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :player_card
      t.string :banker_card
      t.string :winner, index: true 
      t.references :simulation, foreign_key: true

      t.timestamps
    end
  end
end
