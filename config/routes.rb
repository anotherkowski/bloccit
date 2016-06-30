Rails.application.routes.draw do
  resources :topics do
    resources :posts, except: [:index]
  end
  resources :users, only: [:new, :create]
  post 'confirm' => 'users#confirm'

  get 'about' => 'welcome#about'

  root 'welcome#index'

  get 'welcome/contact'
end
