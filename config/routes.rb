RailsStripeMembershipSaas::Application.routes.draw do
  get "content/silver"
  get "content/gold"
  get "content/platinum"
  devise_for :users
  root "home#index"
  resources :users
end
