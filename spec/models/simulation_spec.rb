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
      expect(simulation.may_run?).to be true
      expect(simulation.run!).to be true
      expect(simulation.may_run?).to be false
      expect(simulation.running?).to be true
      expect(simulation.may_sleep?).to be true
      expect(simulation.sleep!).to be true
    end 
    
    
     it 'should add martangle' do
      simulation.games << [build(:game, :banker_win, :bet_result_win), 
        build(:game, :banker_win,:bet_result_win),
        build(:game, :player_win,:bet_result_win)]
      
      simulation.games << [build(:game, :banker_win,:bet_result_win), 
        build(:game, :banker_win, :bet_result_win), build(:game, :player_win, :bet_result_win)]
      expect(simulation.martingale_wager).to eq(simulation.unit_cost)     
      
      simulation.games << [build(:game, :player_win,:bet_result_lose),
         build(:game, :banker_win,:bet_result_lose), build(:game, :banker_win,:bet_result_lose)]
            
      expect(simulation.martingale_wager).to eq(simulation.unit_cost * 2)               
    end
  end  
  
  it 'should do AIM' do
    simulation.games << [build(:game, :banker_win,:bet_result_win), 
        build(:game, :banker_win, :bet_result_win), build(:game, :player_win, :bet_result_win)]
  
  
    simulation.games << [build(:game, :banker_win, :bet_result_win), 
      build(:game, :banker_win,:bet_result_win),
      build(:game, :player_win,:bet_result_win)]
      
    simulation.games << [build(:game, :banker_win,:bet_result_win)]
    
    aim_hsh = simulation.advanced_inversion_method
    binding.pry
    
    expect(aim_hsh[:bet_position]).to eq('P')
    expect(aim_hsh[:bet_sequence]).to eq(1)
    
    #simulation.games << [build(:game, :banker_win,:bet_result_win)]
    
    #aim_hsh = simulation.advanced_inversion_method
    
   
    
       
  end
  
end
