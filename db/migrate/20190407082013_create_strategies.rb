class CreateStrategies < ActiveRecord::Migration[5.2]
  def change
    create_table :strategies do |t|
      t.string :name
      t.text :description
      t.integer :martingale, default: 0
      t.text :code


      t.timestamps
    end
  end
end
