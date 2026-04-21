Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  # 1. This tells Rails: If someone is logged in, the "Home" is actually the Journals list.
  authenticated :user do
    root to: "journals#index", as: :authenticated_root
  end

  # 2. This tells Rails: If someone is NOT logged in, show them the landing page.
  root to: "pages#home"

  resource :settings, only: [:show] do
    patch :update_profile, on: :member
    patch :update_password, on: :member
    delete :destroy_account, on: :member
  end

  resources :journals do
    resources :journal_entries
  end
end
