require 'rails_helper'

RSpec.describe "roulettes/show", type: :view do
  before(:each) do
    @roulette = assign(:roulette, Roulette.create!(
      :user => nil,
      :bet_amount => 2,
      :sector => "Sector",
      :result => "Result"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Sector/)
    expect(rendered).to match(/Result/)
  end
end
