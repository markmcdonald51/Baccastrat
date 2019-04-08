FactoryBot.define do
  factory :game do  
    player_card {}
    banker_card {}
    winner {}
    
    trait :tie do
      winner { 'tie'}
    end
    
    trait :banker_win do
      winner { 'banker' }
    end  
    
    trait :player_win do
      winner {'player'}
    end
    
  end  
end  
  
