FactoryBot.define do
  factory :simulation do   
    unit_cost { 10 }
    bankroll_start {500}
    current_bankroll {0}
    number_of_decks_in_shoe { 6 }
    
    #association :games, factory: :game, winner: "dealer"
    #association :games, :dealer_win
    #association :games, :dealer_win
    #association :games, :player_win 
    
  end


  factory :faker_simulation, class: Simulation  do   
    unit_cost { [25,50,100].shuffle.first }
    bankroll_start { [500,100,1000].shuffle.first }
    current_bankroll {0}
    number_of_decks_in_shoe {6}
  end


end


