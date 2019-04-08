require 'rails_helper'

RSpec.describe "strategies/new", type: :view do
  before(:each) do
    assign(:strategy, Strategy.new(
      :name => "MyString",
      :description => "MyText",
      :martingale => 1,
      :code => "MyText"
    ))
  end

  it "renders new strategy form" do
    render

    assert_select "form[action=?][method=?]", strategies_path, "post" do

      assert_select "input[name=?]", "strategy[name]"

      assert_select "textarea[name=?]", "strategy[description]"

      assert_select "input[name=?]", "strategy[martingale]"

      assert_select "textarea[name=?]", "strategy[code]"
    end
  end
end
