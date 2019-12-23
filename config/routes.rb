Rails.application.routes.draw do
  devise_for :users
  root to: 'users#new'
  resources :users
  resources :partners
  resources :projects, except: [:index] do
    resources :rooms, except: [:index], shallow: true
  end
  resources :welcome_calls, only: [:index]
  resources :bookings, path: 'bookings/(:booking_auth_token)', only: [:update] do
    get 'welcome_calls/book', to: 'welcome_calls#book', as: 'book_welcome_call'
    resources :welcome_calls, only: [:update, :destroy]
    resources :projects, only: [:index] do
      resources :rooms, only: [:index, :show]
    end
    resources :contracts, only: [:new, :create, :show]
    resources :payments, only: [:new, :create]
  end
  get 'bookings/(:booking_auth_token)/:id/payment', to: 'bookings#payment', as: 'booking_payment'

  get 'home', to: 'pages#home', as: 'home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
