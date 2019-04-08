require 'rails_helper'

RSpec.describe Simulation, type: :model do

  let(:strategy) { create(:strategy) }
  let(:simulation) { create(:simulation, strategy: strategy) }
 
  
   describe "perform as expected on tests..." do

    it "should report nil when current_underdo is called as there needs to be at least 5 games" do
      simulation.games << [build(:game, :banker_win), build(:game, :banker_win), build(:game, :player_win)]
      expect(simulation.current_underdog).to be_nil
    end
    
    
    it "should return the propper position to bet next" do
      simulation.games << [build(:game, :banker_win), build(:game, :banker_win), build(:game, :player_win)]
      simulation.games << [build(:game, :banker_win), build(:game, :banker_win), build(:game, :player_win)]
      expect(simulation.current_underdog).to eq('player')

      simulation.games << [build(:game, :player_win), build(:game, :banker_win), build(:game, :banker_win)]
      expect(simulation.current_underdog).to eq('player')
      
      # Flip to banker as UD
      simulation.games << [build(:game, :player_win), build(:game, :banker_win),build(:game, :player_win)]
      expect(simulation.current_underdog).to eq('banker')

      #expect(simulation.current_underdog).to be_nil
        
    end
    
    it "should return the position if the game is now on a run (3 or more consecutive wins)" do
      expect(simulation.position_on_a_run).to be_nil
      
      simulation.games << [build(:game, :banker_win), build(:game, :banker_win), build(:game, :banker_win)]
      expect(simulation.position_on_a_run).to eq('banker')
      
      simulation.games << [build(:game, :banker_win),build(:game, :banker_win),build(:game, :player_win)]
      expect(simulation.position_on_a_run).to be_nil

      expect(simulation.current_underdog).to eq('player')
      
      simulation.games << [build(:game, :player_win), build(:game, :player_win),build(:game, :player_win)] 
      expect(simulation.current_underdog).to eq('banker')
    end  
  end  
end
