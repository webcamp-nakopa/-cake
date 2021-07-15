Rails.application.routes.draw do

  devise_for :admins, controllers: {
   sessions: 'admin/admins/sessions',
   passwords: 'admin/admins/passwords'
  }
  namespace :admin do
   resources :customers, only: %i(show edit update index)
  # resources :questions, only: %i(index destroy)
  end
  devise_for :customers, controllers: {
    sessions:      'public/customers/sessions',
    passwords:     'public/customers/passwords',
    registrations: 'public/customers/registrations'
  }


  scope module: :public do
    resources :customers ,only: [:index]
    resources :deliverys ,only: [:index, :create, :edit,  :destroy, :update]
    resources :products ,only: [ :index, :show]
    resources :cart_items ,only: [:index, :create, :update, :destroy]
    get 'cart_items/destroy_all'
    get 'homes/top'
    get 'homes/about'
  end


  namespace :admin do
    resources :customers ,only: [:index, :show]
    resources :genres ,only: [:index, :create, :edit, :update]
    resources :products ,only: [:new, :create, :show, :index, :edit, :update]

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
