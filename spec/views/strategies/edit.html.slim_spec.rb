require 'rails_helper'

RSpec.describe "strategies/edit", type: :view do
  before(:each) do
    @strategy = assign(:strategy, Strategy.create!(
      :name => "MyString",
      :description => "MyText",
      :martingale => 1,
      :code => "MyText"
    ))
  end

  it "renders the edit strategy form" do
    render

    assert_select "form[action=?][method=?]", strategy_path(@strategy), "post" do

      assert_select "input[name=?]", "strategy[name]"

      assert_select "textarea[name=?]", "strategy[description]"

      assert_select "input[name=?]", "strategy[martingale]"

      assert_select "textarea[name=?]", "strategy[code]"
    end
  end
end
