Rails.application.routes.draw do
  resources :strategies
  resources :simulations do
    get 'run_simulation', on: :member
  end
  resources :games
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
