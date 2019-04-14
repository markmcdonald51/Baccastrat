FactoryBot.define do
  factory :game do  

    
    player_cards {"6-S,9-D,3-C"}
    player_score { 8 }
    banker_cards {"10-S,J-S,4-H"}
    banker_score {4}
    bet_amount {10}
    bet_position {"B"}
    bet_result {"L"}
    winner {"P"}

    trait :tie do
      winner { 'T'}
    end
    
    trait :banker_win do
      winner { 'B' }
    end  
    
    trait :player_win do
      winner {'P'}
    end
    
    trait :bet_result_lose do     
      bet_result {'L'}
    end
    
    trait :bet_result_win do     
      bet_result {'W'}
    end

    trait :bet_result_tie do     
      bet_result {'T'}
    end

  end  
end  
  
