FactoryBot.define do
  factory :game do  
    player_card {}
    banker_card {}
    winner {}
    
    trait :tie do
      winner { 'T'}
    end
    
    trait :banker_win do
      winner { 'B' }
    end  
    
    trait :player_win do
      winner {'P'}
    end
    
  end  
end  
  
