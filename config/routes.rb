Wypozyczalnia::Application.routes.draw do
  devise_for :users
  
  resources :cars do
    resources :reservations
    resources :rents
  end
  
  resources :reservations
  resources :rents
  
  resources :users do
    resources :cars
    resources :reservations
    resources :rents
  end

   root :to => "home#index"

end
