Esophagus::Application.routes.draw do

  resources :users do
    put 'deliver', on: :member
    put 'deliver_test', on: :member
  end

  match 'auth/twitter/callback'=>'sessions#create', as: 'twitter_callback', via: :all
  match 'logout'=>'sessions#destroy', as: 'logout', via: :all

  root to: 'home#index'
end
