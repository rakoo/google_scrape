Rails.application.routes.draw do
  resources :reports
  resources :keywords
  root 'reports#index'
end
