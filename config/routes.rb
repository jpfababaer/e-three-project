Rails.application.routes.draw do
  resources :bookings
  resources :schedules
  devise_for :users
  root to: "bookings#index"
end
