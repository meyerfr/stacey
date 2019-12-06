Rails.application.routes.draw do
  devise_for :users
  root to: 'users#new'
  resources :users do
    get 'welcome_calls/book', to: 'welcome_calls#book', as: 'book_user_welcome_call'
    resources :welcome_calls, only: [:update, :destroy]
  end
  resources :welcome_calls, only: [:index]
  resources :partners
  get 'home', to: 'pages#home', as: 'home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
