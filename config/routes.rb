Rails.application.routes.draw do

  devise_for :users, controllers: {
     sessions:      'users/sessions',
     passwords:     'users/passwords',
     registrations: 'users/registrations'
   }

  namespace :users do
    # get 'relationships/followings'
    # get 'relationships/followers'
    resources :opinions
    # get 'opinions/index'
    # get 'opinions/show'
    # get 'opinions/edit'
    resources :reviews
    # get 'reviews/new'
    # get 'reviews/index'
    # get 'reviews/show'
    # get 'reviews/edit'
    resources :users
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
    # get 'users/index'
    # get 'users/show'
    # get 'users/edit'
  end

  devise_for :admins, controllers: {
     sessions:      'admins/sessions',
     passwords:     'admins/passwords',
     registrations: 'admins/registrations'
   }

  namespace :admins do
  resources :users
  end

  root to: "homes#top"

  get 'homes/about' => "homes#about", as: "about"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
