Rails.application.routes.draw do

  devise_for :users

  namespace :admin do 
    resources :products #do
    #  resources :photos
    #end
    resources :orders do
      member do
        post :cancel
        post :ship
        post :deliver
        post :return
      end  
    end
  end

  namespace :admin do 
    resources :photos 
  end  

  namespace :account do 
    resources :orders
  end  


  # Adding member routes
  # resources :photos do
  #   member do
  #     get :preview
  #   end
  # end
  # This will recoginize /photos/1/preview with GET and route to the preview action of 
  # PhotosController, with resoucre id value passed in params[:id]
  
  resources :products do 
    collection do
      post :search
    end  
    member do 
      post :add_to_cart
    end
  end

  # Adding collection routes
  # resources :photos do 
  #   collection do
  #     get 'search'
  #   end
  # end
  # This will enable Rails to recognize paths such as /photos/search and route to the
  # search action of PhotosController

  resources :carts do 
    collection do 
      post :checkout
      post :delete_all
      post :delete_item
      post :change_item_quantity
    end
  end

  resources :orders

  resources :orders do 
    member do 
      get :pay_with_credit_card
    end
    resources :card_charges  
  end
  

  root :to => "products#index"


end
