Rails.application.routes.draw do
  devise_for :users
  root to: 'users#new'
  resources :users
  resources :partners
  resources :welcome_calls
  get 'home', to: 'pages#home', as: 'home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
