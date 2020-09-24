Rails.application.routes.draw do

  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


	root 'homes#top'
	get 'homes/about' => 'homes#about', as: 'about'
	get 'homes/pfc_calculation' => 'homes#pfc_calculation', as: 'pfc_calculation'

	get 'users/leave' => 'users#leave', as: 'leave'
	patch 'users/hide' => 'users#hide', as: 'hide'
	resources :users, only: [:show, :index, :edit, :update]


  get 'recipes/search' => 'recipes#search', as: 'search_recipes'
  get 'recipes/input' => 'recipes#input', as: 'input_recipe'
  get 'recipes/confirm' => 'recipes#confirm', as: 'confirm_recipe'
	resources :recipes

  resources :recipe_ingredients, only: [:create, :edit, :update, :destroy]
  resources :intake_ingredients, only: [:edit, :update, :destroy]
  resources :intake_recipes, only: [:edit, :update, :destroy]

  post 'intake_ingredient' => 'intake_ingredients#create', as: 'create_intake_ingredient'

  post 'intake_recipe' => 'intake_recipes#create', as: 'create_intake_recipe'

	resources :intake_logs, only: [:index, :show]
  resources :progress_logs
  resources :ingredients
end
