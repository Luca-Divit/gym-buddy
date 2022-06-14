Rails.application.routes.draw do
  get 'notifications/index'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [ :index, :show , :update ] do
    member do
      get :setting
      get :map
    end
    collection do
      get :homepage
    end
    resources :matches, only: [ :index, :update, :create ] do
      resources :chatrooms, only:[:create,:show ]
    end
  end
end
