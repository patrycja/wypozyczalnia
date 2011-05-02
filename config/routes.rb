Wypozyczalnia::Application.routes.draw do
  devise_for :users
  
  namespace :admin do
    resources :users do
  		member do
  	      get 'become'
  	    end
  	end
    root :to => "users#index"
  end
  
  resources :cars
  resources :reservations
  resources :rents
  
  resources :users do
    resources :cars
    resources :reservations
    resources :rents
  end

   root :to => "home#index"

end
