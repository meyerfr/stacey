Rails.application.routes.draw do
  devise_for :users
  root to: 'users#new'
  resources :users
  resources :partners
  resources :welcome_calls, only: [:index]
  resources :projects do
    resources :rooms, shallow: true
  end
  resources :bookings, path: 'bookings/:booking_auth_token' do
    get 'welcome_calls/book', to: 'welcome_calls#book', as: 'book_welcome_call'
    resources :welcome_calls, only: [:update, :destroy]
  end
  resources :contracts
  get 'home', to: 'pages#home', as: 'home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
