class CreateRoulettes < ActiveRecord::Migration[5.2]
  def change
    create_table :roulettes do |t|
      #t.references :user, foreign_key: true
      t.integer :bet_amount
      t.integer :win_amount
      t.string :sector
      t.string :result
      t.integer :number_drawn

      t.timestamps
    end
  end
end
