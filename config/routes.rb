Rails.application.routes.draw do




  root to: 'public/homes#top'

  devise_for :admins, controllers: {
   sessions: 'admin/admins/sessions',
   passwords: 'admin/admins/passwords'
  }

  namespace :admin do
   #resources :customers, only: %i(show edit update index)
  # resources :questions, only: %i(index destroy)
  end
  devise_for :customers, controllers: {
    sessions:      'public/customers/sessions',
    passwords:     'public/customers/passwords',
    registrations: 'public/customers/registrations'
  }


  scope module: :public do
    get 'orders/thank_you' => 'orders#thank_you'
    resources :orders ,only: [:new ,:index ,:show ,:create] do
      collection do
        post :confirm
      end
    end

    resources :customers ,only: [:show,:edit,:update]
    resources :deliveries ,only: [:index, :create, :edit, :destroy, :update]
    resources :products ,only: [ :index, :show]

    get 'search' => 'products#search'
    delete '/cart_items/destroy_all'
    resources :cart_items ,only: [:index, :create, :update, :destroy]

    get '/' => 'homes#top', as: 'homes_top'
    get 'homes/about'
    get 'customers/:id/confirm' => 'customers#confirm', as: 'customers_confirm'
    patch 'customers/destroy/:id' => 'customers#destroy' , as: 'customers_destroy'
    get 'public/search' => 'searches#search', as: 'public_search'
  end


  namespace :admin do
    get '/customer/order/:id' => 'orders#customerindex',as: 'customer_orders'
    resources :orders ,only: [:show,:index,:update]
    resources :order_details ,only: [:update]
    resources :customers ,only: [:index, :show, :edit, :update]
    resources :genres ,only: [:index, :create, :edit, :update, :destroy]
    get "/genres/:id", to: "genres#edit"
    resources :products ,only: [:new, :create, :show, :index, :edit, :update, :destroy]
    root to: 'homes#top'
    get '/search', to: 'searches#search'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
