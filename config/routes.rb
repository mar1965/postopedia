Rails.application.routes.draw do
  resources :wikis

  devise_for :users

  get 'about' => 'welcome#about'

  root 'welcome#index'

  resources :charges, only: [:new, :create]
  post 'users/downgrade' => 'users#downgrade', :as => 'downgrade_user'

end
