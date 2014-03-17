RailsStripeMembershipSaas::Application.routes.draw do
  get "content/silver"
  get "content/gold"
  get "content/platinum"
  devise_for :users, controllers: { registration: 'registration'}
  root "home#index"
  resources :users
end
