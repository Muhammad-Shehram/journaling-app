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
  get "/terms",   to: "pages#terms",   as: :terms
  get "/privacy", to: "pages#privacy", as: :privacy

  resource :settings, only: [:show] do
    patch  :update_profile,    on: :member
    patch  :update_password,   on: :member
    patch  :update_reminders,  on: :member
    patch  :update_appearance, on: :member
    delete :destroy_account,   on: :member
    get    :export,            on: :member
  end

  get    "/recently_deleted",             to: "recently_deleted#index",       as: :recently_deleted_index
  patch  "/recently_deleted/recover_all", to: "recently_deleted#recover_all", as: :recover_all_recently_deleted
  patch  "/recently_deleted/:id/recover", to: "recently_deleted#recover",     as: :recover_recently_deleted
  delete "/recently_deleted/:id",         to: "recently_deleted#destroy",     as: :destroy_recently_deleted
  delete "/recently_deleted",             to: "recently_deleted#purge_all",   as: :purge_all_recently_deleted

  get "/stats",             to: "stats#index",   as: :stats

  get "/prompts",           to: "prompts#index", as: :prompts
  get "/prompts/:category", to: "prompts#show",  as: :prompt_category

  resources :journals do
    resources :journal_entries
  end

  # GoodJob dashboard — re-enable with admin: ->(u) { u.admin? } once admin role is added
  # authenticate :user, ->(u) { u.admin? } do
  #   mount GoodJob::Engine => "/good_job"
  # end
end
