Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 root to: 'toppages#index'
 
 get 'signin', to: 'sessions#new'
 post 'signin', to: 'sessions#create'
 delete 'signout', to: 'sessions#destroy'
 
 get 'signup', to: 'users#new'
 resources :users, only: [:index, :show, :new, :create]
end
