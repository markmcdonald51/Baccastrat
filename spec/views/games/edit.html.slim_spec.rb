require 'rails_helper'

RSpec.describe "games/edit", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      :player_card => "MyString",
      :dealer_card => "MyString",
      :winner => "MyString",
      :simulation => nil
    ))
  end

  it "renders the edit game form" do
    render

    assert_select "form[action=?][method=?]", game_path(@game), "post" do

      assert_select "input[name=?]", "game[player_card]"

      assert_select "input[name=?]", "game[dealer_card]"

      assert_select "input[name=?]", "game[winner]"

      assert_select "input[name=?]", "game[simulation_id]"
    end
  end
end
