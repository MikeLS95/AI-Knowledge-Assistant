Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  authenticated :user do
    root "dashboard#index", as: :authenticated_root
  end

  unauthenticated do
    root "pages#home", as: :unauthenticated_root
  end

  get "pages/home", as: "pages_home"
  get "dashboard/index", as: "dashboard_index"

  resources :documents, only: [:index, :new, :create, :show, :destroy] do
    member do
      get :download
    end
  end

  root 'pages#home'
end
