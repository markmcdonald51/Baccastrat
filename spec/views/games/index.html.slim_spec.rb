require 'rails_helper'

RSpec.describe "games/index", type: :view do
  before(:each) do
    assign(:games, [
      Game.create!(
        :player_card => "Player Card",
        :dealer_card => "Dealer Card",
        :winner => "Winner",
        :simulation => nil
      ),
      Game.create!(
        :player_card => "Player Card",
        :dealer_card => "Dealer Card",
        :winner => "Winner",
        :simulation => nil
      )
    ])
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", :text => "Player Card".to_s, :count => 2
    assert_select "tr>td", :text => "Dealer Card".to_s, :count => 2
    assert_select "tr>td", :text => "Winner".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
