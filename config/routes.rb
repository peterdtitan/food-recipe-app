Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
  end
  root "home#index"

  resources :recipes do
    resources :recipe_foods, except: [:index]
  end

  resources :foods, only: [:index, :show, :new, :create, :destroy]

  get "public_recipes", to: "public_recipes#index"
  get "shopping_list", to: "shopping_list#index"
  get 'home/index', to: "home#index"

end

