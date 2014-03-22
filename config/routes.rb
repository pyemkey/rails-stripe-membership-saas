RailsStripeMembershipSaas::Application.routes.draw do
  get "content/silver"
  get "content/gold"
  get "content/platinum"
  devise_for :users, controllers: { registrations: 'registrations'}
  root "home#index"
  devise_scope :user do
    patch 'update_plan', to: "registrations#update_plan"
    patch 'update_card', to: "registrations#update_card"
  end
  resources :users
end
