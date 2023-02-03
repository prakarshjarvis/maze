Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :likes, only: [:create, :destroy]
  resources :posts
  resources :comments
  get 'page/index'
  get "/page/deactivate", to: "page#deactivate"
  get "/page/activate", to: "page#activate"
  get  '/page/new',  to: 'page#new'
  post 'page/create',  to: 'page#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'page#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
