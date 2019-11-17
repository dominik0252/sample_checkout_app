Rails.application.routes.draw do
  get 'order_items/show'
  get 'baskets/show'
  root 'items#index'
  resources :basket_items, only: [:index, :create, :destroy]
  resources :customers, only: [:new, :create]
  resources :credit_cards, only: [:new, :create]
  resources :promotions, only: [:index]
  resources :orders, only: [:new, :create, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
