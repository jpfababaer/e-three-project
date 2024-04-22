Rails.application.routes.draw do
  root "homes#landing"

  resources :bookings, except: [:show]
  resources :schedules, except: [:show]
  devise_for :users, controllers: { sessions: 'sessions' }
end
