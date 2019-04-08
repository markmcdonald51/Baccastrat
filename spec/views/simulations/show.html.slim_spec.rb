require 'rails_helper'

RSpec.describe "simulations/show", type: :view do
  before(:each) do
    @simulation = assign(:simulation, Simulation.create!(
      :strategy => nil,
      :unit_cost => 2,
      :bankroll_start => 3,
      :current_bankroll => 4,
      :number_of_decks_in_shoe => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
  end
end
