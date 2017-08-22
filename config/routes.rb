Rails.application.routes.draw do
  resources :wikis
  resources :charges, only: [:new, :create]
  resources :downgrade, only: [:new, :create]
  post 'downgrade/create'

  devise_for :users do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end

  root 'welcome#index'
end
