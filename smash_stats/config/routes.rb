Rails.application.routes.draw do
  devise_for :users
  root  "static_pages#root"
  namespace :api, defaults: {format: :json} do
    resources :news, only: [:index, :create]
    resources :players, only: [:index, :show]
    resources :tournaments, only: [:index, :create, :destroy]
    resource :challonge, only: :update
  end
end
