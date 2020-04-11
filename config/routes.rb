Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :user_categories, only: %i[edit update]

  get 'profile', to: 'profiles#show', as: 'profile'

  get 'render_form_posts', to: "posts#render_form", as: 'render_form_posts'
  post 'send_link', to: 'posts#parse_link', as: 'send_link'
end
