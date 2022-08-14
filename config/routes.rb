Rails.application.routes.draw do

  devise_for :users, controllers: {
     sessions:      'users/sessions',
     passwords:     'users/passwords',
     registrations: 'users/registrations'
   }

  namespace :users do
    resources :opinions do
      resource :opinion_favorites, only: [:create, :destroy]
      resources :opinion_comments, only: [:create, :destroy]
    end

    resources :reviews do
      resource :review_favorites, only: [:create, :destroy]
      resources :review_comments, only: [:create, :destroy]
    end

    resources :users do
       member do
          get :favorites
        end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      get 'unsubscribe/:id' => 'users#unsubscribe', as: 'confirm_unsubscribe'
      patch ':id/withdraw' => 'users#withdraw', as: 'withdraw_user'
      put 'withdraw' => 'users#withdraw'
      get "search" => "searches#search"
    end

  end

  devise_for :admins, controllers: {
     sessions:      'admins/sessions',
     passwords:     'admins/passwords',
     registrations: 'admins/registrations'
   }

  namespace :admins do
    resources :opinions do
      resource :opinion_favorites, only: [:create, :destroy]
      resources :opinion_comments, only: [:create, :destroy]
    end

    resources :reviews do
      resource :review_favorites, only: [:create, :destroy]
      resources :review_comments, only: [:create, :destroy]
    end

    resources :users
  end

  root to: "homes#top"

  get 'homes/about' => "homes#about", as: "about"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
