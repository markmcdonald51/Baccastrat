require 'rails_helper'

RSpec.describe "games/new", type: :view do
  before(:each) do
    assign(:game, Game.new(
      :player_card => "MyString",
      :dealer_card => "MyString",
      :winner => "MyString",
      :simulation => nil
    ))
  end

  it "renders new game form" do
    render

    assert_select "form[action=?][method=?]", games_path, "post" do

      assert_select "input[name=?]", "game[player_card]"

      assert_select "input[name=?]", "game[dealer_card]"

      assert_select "input[name=?]", "game[winner]"

      assert_select "input[name=?]", "game[simulation_id]"
    end
  end
end
