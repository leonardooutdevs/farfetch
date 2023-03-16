Rails.application.routes.draw do
  resources :social_networks, only: :index

  root 'social_networks#index'
end
