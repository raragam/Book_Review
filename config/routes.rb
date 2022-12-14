Rails.application.routes.draw do

  namespace :admins do
    get 'opinion_comments/destroy'
  end
  namespace :admins do
    get 'review_comments/destroy'
  end

  devise_for :users, controllers: {
     sessions:      'users/sessions',
     passwords:     'users/passwords',
     registrations: 'users/registrations',
     #omniauth_callbacks: 'users/omniauth_callbacks'
  }

  #namespace :users do
  scope module: :users do
    resources :opinions do
      resource :opinion_favorites, only: [:create, :destroy]
      resources :opinion_comments, only: [:create, :destroy]
    end

    resources :reviews do
      resource :review_favorites, only: [:create, :destroy]
      resources :review_comments, only: [:create, :destroy]
    end

    resources :contacts

    resources :users do
       member do
        get :opinions_user_index
       end
       member do
        get :reviews_user_index
       end
       member do
        get :opinion_favorites
       end
       member do
        get :review_favorites
       end
       resource :relationships, only: [:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
        get 'unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
        patch 'withdraw' => 'users#withdraw', as: 'withdraw_user'
        put 'withdraw' => 'users#withdraw'
        get "search" => "searches#search"
        resources :reports, only: [:new, :create]
    end

  end

  devise_for :admins,

    # path: 'auth',
    # path_names: {
    # sign_in: 'xxxxxxxxxx',
    # sign_out: 'xxxxxxxxxx',
    # password: 'xxxxxxxxxx',
    # confirmation: 'xxxxxxxxxx',
    # unlock: 'xxxxxxxxxx',
    # registration: 'xxxxxxxxxx',
    # sign_up: 'xxxxxxxxxx' },

     controllers: {
     sessions:      'admins/sessions',
     passwords:     'admins/passwords',
     registrations: 'admins/registrations'
   }

  namespace :admins do
    resources :opinions do
      resource :opinion_favorites, only: [:create, :destroy]
      resources :opinion_comments, only: [:destroy]
    end

    resources :reviews do
      resource :review_favorites, only: [:create, :destroy]
      resources :review_comments, only: [:destroy]
    end

    resources :users do
      member do
        get :opinions_user_index
      end
      member do
        get :reviews_user_index
      end
    end

    resources :reports, only: [:index, :show, :update]

    resources :contacts

  end

  root to: "homes#top"

  get 'homes/about' => "homes#about", as: "about"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
