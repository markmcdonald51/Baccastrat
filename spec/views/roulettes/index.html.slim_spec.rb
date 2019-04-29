require 'rails_helper'

RSpec.describe "roulettes/index", type: :view do
  before(:each) do
    assign(:roulettes, [
      Roulette.create!(
        :user => nil,
        :bet_amount => 2,
        :sector => "Sector",
        :result => "Result"
      ),
      Roulette.create!(
        :user => nil,
        :bet_amount => 2,
        :sector => "Sector",
        :result => "Result"
      )
    ])
  end

  it "renders a list of roulettes" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Sector".to_s, :count => 2
    assert_select "tr>td", :text => "Result".to_s, :count => 2
  end
end
