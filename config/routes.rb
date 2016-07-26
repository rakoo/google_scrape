Rails.application.routes.draw do
  resources :keywords do
    resources :urls
  end
  resources :urls
  root 'keywords#index'
end
