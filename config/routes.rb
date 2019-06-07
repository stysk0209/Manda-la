Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'mandalas#top'

  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]

  resources :mandalas

  get 'sessions/log_in', as: 'log_in'
  get 'sessions/log_out', as: 'log_out'

end
