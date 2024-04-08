Rails.application.routes.draw do

  root "homes#landing"

  resources :bookings
  resources :schedules
  devise_for :users

end
