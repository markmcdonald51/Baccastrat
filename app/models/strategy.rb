class Strategy < ApplicationRecord
  has_many :strategy_simulations
  has_many :simulations, through: :strategy_simulations
  
  
  def preform 
    SimulatorWorker.perform_async(self.id)
  end
  
end
