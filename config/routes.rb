Rails.application.routes.draw do

  resources :posts, :advertisements

  get 'about' => 'welcome#about'
  get 'contact' => 'welcome#contact'
  get 'posts' => 'posts#index'
  get 'advertisements' => 'advertisements#index'

  root 'welcome#index'

end
