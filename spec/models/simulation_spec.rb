require 'rails_helper'

RSpec.describe Simulation, type: :model do

  let(:strategy) { create(:strategy) }
  let(:simulation) { create(:simulation) }
 
  before(:each) do
    simulation.strategies << strategy
  end
   
   describe "perform as expected on tests..." do

    it "should report nil when current_underdo is called as there needs to be at least 5 games" do
      simulation.games << [build(:game, :banker_win), build(:game, :banker_win), build(:game, :player_win)]
      expect(simulation.current_underdog).to be_nil
    end
    
    
    it "should return the propper position to bet next" do
      simulation.games << [build(:game, :banker_win), build(:game, :banker_win), build(:game, :player_win)]
      simulation.games << [build(:game, :banker_win), build(:game, :banker_win), build(:game, :player_win)]
      expect(simulation.current_underdog).to eq('P')

      simulation.games << [build(:game, :player_win), build(:game, :banker_win), build(:game, :banker_win)]
      expect(simulation.current_underdog).to eq('P')
      
      # Flip to banker as UD
      simulation.games << [build(:game, :player_win), build(:game, :banker_win),build(:game, :player_win)]
      expect(simulation.current_underdog).to eq('B')

      #expect(simulation.current_underdog).to be_nil
        
    end
    
    it "should return the position if the game is now on a run (3 or more consecutive wins)" do
      expect(simulation.position_on_a_run).to be_nil
      
      simulation.games << [build(:game, :banker_win), build(:game, :banker_win), build(:game, :banker_win)]
      expect(simulation.position_on_a_run).to eq('B')
      
      simulation.games << [build(:game, :banker_win),build(:game, :banker_win),build(:game, :player_win)]
      expect(simulation.position_on_a_run).to be_nil

      expect(simulation.current_underdog).to eq('P')
      
      simulation.games << [build(:game, :player_win), build(:game, :player_win),build(:game, :player_win)] 
      expect(simulation.current_underdog).to eq('B')
    end  
    
    it 'should change states' do
      #binding.pry
      expect(simulation.may_run?).to be true
      expect(simulation.run!).to be true
      expect(simulation.may_run?).to be false
      expect(simulation.running?).to be true
      expect(simulation.may_sleep?).to be true
      expect(simulation.sleep!).to be true
      
      #binding.pry
    end 
    
  end  
end
