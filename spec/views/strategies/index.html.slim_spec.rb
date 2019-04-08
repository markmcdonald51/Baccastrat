require 'rails_helper'

RSpec.describe "strategies/index", type: :view do
  before(:each) do
    assign(:strategies, [
      Strategy.create!(
        :name => "Name",
        :description => "MyText",
        :martingale => 2,
        :code => "MyText"
      ),
      Strategy.create!(
        :name => "Name",
        :description => "MyText",
        :martingale => 2,
        :code => "MyText"
      )
    ])
  end

  it "renders a list of strategies" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
