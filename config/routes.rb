Rails.application.routes.draw do
  resources :urls
  resources :keywords
  root 'keywords#index'
end
