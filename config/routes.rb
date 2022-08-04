Rails.application.routes.draw do
  devise_for :admins, controllers: {
   sessions:      'admins/sessions',
   passwords:     'admins/passwords',
   registrations: 'admins/registrations'
}
  devise_for :customers, controllers: {
   sessions:      'customers/sessions',
   passwords:     'customers/passwords',
   registrations: 'customers/registrations'
}

  namespace :admin do
    root to: "homes#top"
    resources :customers, only: [:show, :index, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
