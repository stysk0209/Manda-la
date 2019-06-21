Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'mandalas#top'

  devise_for :users, :controllers => {
 :registrations => 'users/registrations',
 :sessions => 'users/sessions'
 }

  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]

  resources :mandalas

  get 'tasks/:id/done' => 'tasks#done', as: 'task_done'
  resources :tasks, only: [:create, :destroy]

end
