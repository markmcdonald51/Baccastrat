require 'rails_helper'

RSpec.describe Strategy, type: :model do
   
  let(:strategy) { build(:strategy) }
  
  describe "test model for initial values and connected libs" do
    it "has 0 widgets" do
      strategy.save!
      strategy.preform
      #@thing.should have(0).widgets
    end

    it "can get accept new widgets" do   
    end

    it "shares state across examples" do
    end
  end

  
  
end
