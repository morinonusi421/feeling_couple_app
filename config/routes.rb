Rails.application.routes.draw do
  root to:'static_pages#home'
  resources :users
  resources :parties
  get "/newparty", to: "parties#new"
  get "/searchparty", to: "parties#search"
end
