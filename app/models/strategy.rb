class Strategy < ApplicationRecord
  has_many :simulations
  
  
  def preform 
    SimulatorWorker.perform_async(self.id)
  end
  
end
