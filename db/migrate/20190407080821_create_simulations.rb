class CreateSimulations < ActiveRecord::Migration[5.2]
  def change
    create_table :simulations do |t|
      t.references :strategy, foreign_key: true
      t.integer :unit_cost
      t.integer :bankroll_start
      t.integer :current_bankroll
      t.integer :number_of_decks_in_shoe, default: 6

      t.timestamps
    end
  end
end
