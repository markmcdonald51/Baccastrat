require 'rails_helper'

RSpec.describe "simulations/index", type: :view do
  before(:each) do
    assign(:simulations, [
      Simulation.create!(
        :strategy => nil,
        :unit_cost => 2,
        :bankroll_start => 3,
        :current_bankroll => 4,
        :number_of_decks_in_shoe => 5
      ),
      Simulation.create!(
        :strategy => nil,
        :unit_cost => 2,
        :bankroll_start => 3,
        :current_bankroll => 4,
        :number_of_decks_in_shoe => 5
      )
    ])
  end

  it "renders a list of simulations" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
