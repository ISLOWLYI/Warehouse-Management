Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  devise_scope :user do
    get "/logout" => "devise/sessions#destroy"
  end

  root "home#index"

  resources :warehouses do
    resources :products
    resources :warehouse_users, path: "users", only: [:index, :create, :update, :destroy] do
      member do
        patch :deactivate
        patch :update_role
      end
      collection do
        post :invite
      end
    end
    member do
      get :map
    end
  end

  get "about", to: "home#about"
end