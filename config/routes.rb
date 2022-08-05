Rails.application.routes.draw do

  namespace :users do
    # resources :opinions, only:[:index, create, :show, :edit, :update, destroy]
    get 'opinions/index'
    get 'opinions/show'
    get 'opinions/edit'
    # resources :users, only:[:index, create, :show, :edit, :update]
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  # devise_for :admins
  # devise_for :users

     devise_for :admins, controllers: {
     sessions:      'admins/sessions',
     passwords:     'admins/passwords',
     registrations: 'admins/registrations'
   }
     devise_for :users, controllers: {
     sessions:      'users/sessions',
     passwords:     'users/passwords',
     registrations: 'users/registrations'
   }

  root to: "homes#top"

  get 'homes/about' => "homes#about", as: "about"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
