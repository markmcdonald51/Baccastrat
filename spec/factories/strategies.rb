FactoryBot.define do
  factory :strategy do
    name { "My Stretgy" }
    description { "My Description" }
    martingale { 3 }
    code { "" } 
    
    #trait :with_underdog_simulation
    #  association :
    #end
  end
  
  
  
end
