require 'rails_helper'

RSpec.describe "strategies/show", type: :view do
  before(:each) do
    @strategy = assign(:strategy, Strategy.create!(
      :name => "Name",
      :description => "MyText",
      :martingale => 2,
      :code => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
