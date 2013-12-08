Esophagus::Application.routes.draw do
  get 'session/new'=>'sessions#new', as: 'login'
  match 'auth/twitter/callback'=>'sessions#create', as: 'twitter_callback', via: :all
  match 'logout'=>'sessions#destroy', as: 'logout', via: :all

  root to: 'home#index'
end
