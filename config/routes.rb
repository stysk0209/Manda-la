Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => {
 :registrations => 'users/registrations',
 :sessions => 'users/sessions'
 }

  root to: 'mandalas#top'

  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]

  get 'mandalas/about', as: 'mandala_about'
  resources :mandalas

end
