require 'sidekiq/web'

Sidekiq::Web.use Rack::Session::Cookie, secret: ENV.fetch('SECRET_KEY_BASE', nil),
                                        same_site: true, max_age: 86_400

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :social_networks, only: :index

  root 'social_networks#index'
end
