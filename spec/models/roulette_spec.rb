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
      1.upto(6) { FactoryBot.create(:roulette, number_drawn: 2) }
      expect(Roulette.underdog(depth:3)).to include(:second_12, :third_12)
      
      1.upto(6) { FactoryBot.create(:roulette, number_drawn: 13) }
      expect(Roulette.underdog(depth: 7)).to include(:third_12)
     
     
      1.upto(6) { FactoryBot.create(:roulette, number_drawn: 26) }
      expect(Roulette.underdog(depth:3)).to include(:first_12)
      
      
    end
  end
end



