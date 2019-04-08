class CreateStrategySimulations < ActiveRecord::Migration[5.2]
  def change
    create_table :strategy_simulations do |t|
      t.references :strategy, foreign_key: true
      t.references :simulation, foreign_key: true

      t.timestamps
    end
  end
end
