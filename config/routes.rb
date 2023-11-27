Rails.application.routes.draw do
  get 'static_pages/home'
  root to:'static_pages#home'
  resources :users
  get  "/makeuser",  to: "users#new"
end
