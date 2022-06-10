Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [ :index, :show, :update ] do
    resources :chatrooms, only:[:create, :index, :show ]
    member do
      get :setting
    end
    resources :matches, only: [ :index, :update, :create ] do
    end
  end
end
