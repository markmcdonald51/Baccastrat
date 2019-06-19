require 'rails_helper'

RSpec.describe Roulette, type: :model do
  let(:r) { create(:roulette) }
  
  describe "perform as expected on tests..." do
    it 'should have 36 numbers' do
      expect(Roulette::NUMBERS.length).to eql(38)
    end

    it 'should draw value between 0 and 37' do    
      expect(0..37).to include(r.draw)
    end    
    
    it 'first_12 should return true' do    
      expect(Roulette.first_12_win?(r.number_drawn)).to be true
    end    
    
    it 'should draw 100 times' do
      1.upto(100) do |n|
        test =  create(:roulette, number_drawn: Roulette.draw_number )
        puts "#{n}] #{test.number_drawn}"
        if Roulette.first_12_win?(test.number_drawn)
          puts "win first 12: #{test.win_amount}"   
        end
      end
      true
    end

    it 'should return underdog' do
      1.upto(10) do |n|
        create(:roulette)
      end        
      ud = Roulette.underdog
      expect(ud).to include(:second_12, :third_12)
      expect(ud.count).to eql(2)  
    end 
    
    it 'should return underdog for respected item' do
      3.times { FactoryBot.create(:roulette, number_drawn: 2) }
      expect(Roulette.underdog(depth:3, min_draws: 3)).
        to include(:second_12, :third_12)

      1.times { FactoryBot.create(:roulette, number_drawn: 13) }
      expect(Roulette.underdog(depth: 7).length).to eql(0)
      
      5.times { FactoryBot.create(:roulette, number_drawn: 13) }
      expect(Roulette.underdog(depth: 7)).to include(:third_12)
       
      3.times { FactoryBot.create(:roulette, number_drawn: 26) }
      expect(Roulette.underdog(depth:3)).to include(:first_12)  
      
      1.times { FactoryBot.create(:roulette, number_drawn: 2) }
      expect(Roulette.underdog(depth:3)).to include(:second_12)  
      
      1.times { FactoryBot.create(:roulette, number_drawn: 13) }
      expect(Roulette.underdog(depth:3).length).to eql(0)   
    end
    
    it 'should return [] unless min_draws' do
      expect(Roulette.underdog(depth:3).length).to eq(0) 
      1.times { FactoryBot.create(:roulette, number_drawn: 13) }
    end

    it 'should' do
      5.times do |n|
        test = create(:roulette, number_drawn: Roulette.draw_number ) 
        Roulette.underdog(depth:5,  min_draws: 5)
        puts "#{n}] #{test.number_drawn}" 100
      end
      # Baccarat FUTURE SYSYTEM
      #   Bet on the second tie (which should come soon after the first).
      #   After the secons tie with for third and repeat.
      
      # Bet 50 when 
      
      # Strategies
      #   RampUp
      
      # Methods to create in gambling module
      #  - last_three_underdog
      #  - ride_the_streak
      #  - up_the_bet
      #   - add_a_unit (up_a_unit)
      #   - ride_the_elevator (down)
      #   - crossover (change from banker to player) or black to white...
      #   - stern_method
      #### BETTING
      #  - add_a_unit
      #  - martingale
      #  - double
      #   - house_way (up 2 units each win)
      #     example -- follow house way, then martingale when your losing
      
      # Stop Loss [ex. 4 loses in a row]      
        
      ## Parameters
      #  set_goal (target amount to win)
      
    end
  end
  
end



