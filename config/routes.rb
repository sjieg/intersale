Rails.application.routes.draw do
  resources :collections
  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions",
    unlocks: "users/unlocks",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users

  resource :pages, only: [:home] do
    collection do
      get :home
      get :components
    end
  end
  # Defines the root path route ("/")
  root to: "collections#index"
end
