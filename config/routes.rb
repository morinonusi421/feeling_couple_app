Rails.application.routes.draw do
  root to:'static_pages#home'
  resources :users do
    post 'bundle_create', on: :collection
  end
  resources :parties, param: :name do
    member do
      delete 'destroy_in_index', to: 'parties#destroy_in_index'
    end
  end
  get "/newparty", to: "parties#new"
  get "/searchparty", to: "parties#search"
  get "/reload", to: 'application#reload'
  get "/debug_parties", to:"parties#debug_index"
  resources :likes, only: [:create, :destroy]
end
