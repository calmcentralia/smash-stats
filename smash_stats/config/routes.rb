Rails.application.routes.draw do
  root  "static_pages#root"
  namespace :api, defaults: {format: :json} do
    resources :players, only: [:index, :show]
    resources :tournaments, only: [:index, :create, :destroy]
    resource :challonge, only: :create
  end
end
