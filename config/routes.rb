Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :user_categories, only: %i[edit update]

  get 'profile', to: 'profiles#show', as: 'profile'

  resources :posts, only: %i[index show]
  get 'user_posts',to: 'posts#user_posts', as: 'user_posts'
  get 'posts_with_included_categories', to: 'posts#posts_with_included_categories', as: 'posts_with_included_categories'
  get 'render_form_posts', to: 'posts#render_form', as: 'render_form_posts'
  post 'send_link', to: 'posts#parse_link', as: 'send_link'
end
