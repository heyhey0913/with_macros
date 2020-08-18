Rails.application.routes.draw do

  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


	root 'homes#top'
	get 'homes/about' => 'homes#about', as: 'about'
	get 'homes/pfc_calculation' => 'homes#pfc_calculation', as: 'pfc_calculation'

end
