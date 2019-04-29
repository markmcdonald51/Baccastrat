require 'rails_helper'

RSpec.describe "roulettes/new", type: :view do
  before(:each) do
    assign(:roulette, Roulette.new(
      :user => nil,
      :bet_amount => 1,
      :sector => "MyString",
      :result => "MyString"
    ))
  end

  it "renders new roulette form" do
    render

    assert_select "form[action=?][method=?]", roulettes_path, "post" do

      assert_select "input[name=?]", "roulette[user_id]"

      assert_select "input[name=?]", "roulette[bet_amount]"

      assert_select "input[name=?]", "roulette[sector]"

      assert_select "input[name=?]", "roulette[result]"
    end
  end
end
