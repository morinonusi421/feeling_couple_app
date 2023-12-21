Rails.application.routes.draw do
  root to:'static_pages#home'
  resources :users
  resources :parties, param: :name do
    member do
      delete 'destroy_in_index', to: 'parties#destroy_in_index'
    end
  end
  get "/newparty", to: "parties#new"
  get "/searchparty", to: "parties#search"
  get "/reload", to: 'application#reload'
  resources :likes, only: [:create, :destroy]
end
