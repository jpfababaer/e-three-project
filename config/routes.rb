Rails.application.routes.draw do

  root "users#landing"

  resources :bookings
  resources :schedules
  devise_for :users

end
