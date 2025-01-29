Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  match "*path", to: "application#not_found", via: :all
end
