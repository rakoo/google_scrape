Rails.application.routes.draw do
  resources :keywords
  root 'keywords#index'
end
