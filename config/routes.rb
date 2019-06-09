Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'mandalas#top'

  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]

  resources :mandalas
  get 'mandalas/about', as: 'mandala_about'

end
