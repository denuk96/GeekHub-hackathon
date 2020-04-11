Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :user_categories
end
