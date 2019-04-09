class Strategy < ApplicationRecord
  has_many :strategy_simulations
  has_many :simulations, through: :strategy_simulations
  
  
   
end
