require 'rails_helper'

RSpec.describe "games/show", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      :player_card => "Player Card",
      :dealer_card => "Dealer Card",
      :winner => "Winner",
      :simulation => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Player Card/)
    expect(rendered).to match(/Dealer Card/)
    expect(rendered).to match(/Winner/)
    expect(rendered).to match(//)
  end
end
