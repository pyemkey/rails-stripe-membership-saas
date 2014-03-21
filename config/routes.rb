RailsStripeMembershipSaas::Application.routes.draw do
  get "content/silver"
  get "content/gold"
  get "content/platinum"
  devise_for :users, controllers: { registrations: 'registrations'}
  root "home#index"
  devise_scope :user do
    put 'update_plan', to: "registrations#update_plan"
    put 'update_card', to: "registrations#update_card"
  end
  resources :users
end
