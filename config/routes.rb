Rails.application.routes.draw do

  devise_for :users
  namespace :admin do 
    resources :products
    resources :orders do
      member do
        post :cancel
        post :ship
        post :deliver
        post :return
      end  
    end
  end
  
  namespace :account do 
    resources :orders
  end  



  resources :products do 
    member do 
      post :add_to_cart
    end
  end

  resources :carts do 
    collection do 
      post :delete_all
      post :delete_item
      post :change_item_quantity
    end
  end




  resources :carts do 
    collection do 
      post :checkout
    end
  end

  resources :orders

  resources :orders do 
    member do 
      get :pay_with_credit_card
    end
  end
  

  root :to => "products#index"


end
