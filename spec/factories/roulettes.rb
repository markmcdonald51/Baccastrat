FactoryBot.define do
  factory :roulette do
    bet_amount { 50 }
    win_amount { 150 }
    sector { "first_12" }
    number_drawn { 1}
    result { "win" }
  end
end
