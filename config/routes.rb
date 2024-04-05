Rails.application.routes.draw do
  resources :schedules
  devise_for :users
  root to: "bookings#index"
end
