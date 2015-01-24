Rails.application.routes.draw do
  
  resources :users do 
    resources :filters, only: [:new,:create]
  end
  
  resources :messages
  resources :filters, only: [:show,:index,:create,:destroy]

  resources :sessions, only: [:destroy], as: :logout

  root 'home#index', as: 'home', layout: 'false'
  match 'auth/twitter/callback', to: 'sessions#create', via: [:get, :post]

  # Message Control
  get '/refresh' => 'messages#refresh', as: 'refresh'
  get '/analyze' => 'messages#analyze', as: 'analyze'
  get '/destroy-all-messages' => 'messages#destroy', as: 'destroy_all_messages'
  get '/destroy-filter' => 'filters#destroy', as: 'destroy_filter'
  
end
