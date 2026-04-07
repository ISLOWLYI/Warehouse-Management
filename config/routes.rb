Rails.application.routes.draw do
  devise_for :users
  
  devise_scope :user do
    get "/logout" => "devise/sessions#destroy"
  end
  
  root "home#index"
  get "warehouse", to: "warehouse#info"
end