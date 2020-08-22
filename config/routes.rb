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
	resources :users, only: [:show, :index]

	get 'projects/:id/graph' => 'projects#graph', as: 'graph'
	resources :projects

	get 'recipes/search' => 'recipes#search', as: 'search'
	resources :recipes

end
