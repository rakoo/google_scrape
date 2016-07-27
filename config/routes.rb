Rails.application.routes.draw do
  resources :reports, only: [:show, :index, :new, :destroy]
  resources :keywords, only: [:show, :index]
  root 'reports#index'
end
