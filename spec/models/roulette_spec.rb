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
      expect(r.first_12_win?).to be true
    end    
    
    it 'should draw 100 times' do
      1.upto(100) do |n|
        test =  create(:roulette, number_drawn: Roulette::draw_number )
        puts "#{n}] #{test.number_drawn}"
        if test.first_12_win?
          puts "win first 12: #{test.win_amount}"   
        end
      end
      true
    end
  end
end



