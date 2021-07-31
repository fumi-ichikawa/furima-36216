Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items
  resources :shopping_records, only:[:index, :create]
end
