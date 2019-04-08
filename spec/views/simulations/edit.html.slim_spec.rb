require 'rails_helper'

RSpec.describe "simulations/edit", type: :view do
  before(:each) do
    @simulation = assign(:simulation, Simulation.create!(
      :strategy => nil,
      :unit_cost => 1,
      :bankroll_start => 1,
      :current_bankroll => 1,
      :number_of_decks_in_shoe => 1
    ))
  end

  it "renders the edit simulation form" do
    render

    assert_select "form[action=?][method=?]", simulation_path(@simulation), "post" do

      assert_select "input[name=?]", "simulation[strategy_id]"

      assert_select "input[name=?]", "simulation[unit_cost]"

      assert_select "input[name=?]", "simulation[bankroll_start]"

      assert_select "input[name=?]", "simulation[current_bankroll]"

      assert_select "input[name=?]", "simulation[number_of_decks_in_shoe]"
    end
  end
end
