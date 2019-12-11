Rails.application.routes.draw do
  devise_for :users
  root to: 'users#new'
  resources :users do
    get 'welcome_calls/book', to: 'welcome_calls#book', as: 'book_welcome_call'
    resources :welcome_calls, only: [:update, :destroy]
  end
  resources :partners
  resources :welcome_calls, only: [:index]
  resources :projects do
    resources :rooms, shallow: true
  end
  resources :bookings
  resources :contracts
  get 'home', to: 'pages#home', as: 'home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
