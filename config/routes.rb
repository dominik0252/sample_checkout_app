Rails.application.routes.draw do
  root 'items#index'
  resources :basket_items, only: [:index, :create, :destroy]
  resources :promotions, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
