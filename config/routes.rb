Rails.application.routes.draw do
  root to:'static_pages#home'
  resources :users
  resources :parties
  get  "/makeuser",  to: "users#new"
end
