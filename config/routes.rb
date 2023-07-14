Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :recipes do
    resources :recipe_foods, except: [:index]
  end

  resources :foods, only: [:index, :show, :new, :create, :destroy]

  get "public_recipes", to: "public_recipes#index"
  get "shopping_list", to: "shopping_list#index"
  get 'home/index', to: "home#index"

end

