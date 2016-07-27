Rails.application.routes.draw do
  resources :reports, only: [:show, :index, :new, :destroy, :create]
  resources :keywords, only: [:show, :index]
  get '/keywords/:id/cache', controller: "keywords", action: "cache"

  root 'reports#index'
end
