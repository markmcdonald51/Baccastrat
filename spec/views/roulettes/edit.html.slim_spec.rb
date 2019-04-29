require 'rails_helper'

RSpec.describe "roulettes/edit", type: :view do
  before(:each) do
    @roulette = assign(:roulette, Roulette.create!(
      :user => nil,
      :bet_amount => 1,
      :sector => "MyString",
      :result => "MyString"
    ))
  end

  it "renders the edit roulette form" do
    render

    assert_select "form[action=?][method=?]", roulette_path(@roulette), "post" do

      assert_select "input[name=?]", "roulette[user_id]"

      assert_select "input[name=?]", "roulette[bet_amount]"

      assert_select "input[name=?]", "roulette[sector]"

      assert_select "input[name=?]", "roulette[result]"
    end
  end
end
