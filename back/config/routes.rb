Rails.application.routes.draw do
  namespace :v1 do
    mount_devise_token_auth_for "User", at: "auth", controllers: {
      registrations: "v1/auth/registrations",
      sessions: "v1/auth/sessions"
    }
  end

  resources :posts, only: [:new, :show, :create, :destroy] do
    resource :post_likes, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy] do
      resources :comment_replies, only: [:create, :destroy]
    end
  end
  resources :point_transactions, only: [:create]
  resources :users, only: [:show]
  resources :purchases, only: [:index, :show]
  resources :groups do
    resource :join_groups, only: [:create, :destroy, :edit]
  end

  resources :admins

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
