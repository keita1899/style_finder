Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :recognitions, only: %i[new create]
  match "*path", to: "application#not_found", via: :all
end
