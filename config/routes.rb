Rails.application.routes.draw do

  resources :posts
  resources :questions

  get 'about' => 'welcome#about'

  root 'welcome#index'

  get 'contact' => 'welcome#contact'
end
