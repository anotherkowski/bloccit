Rails.application.routes.draw do
  resources :topics do
    resources :posts, except: [:index]
  end
  # we use only: [] because we don't want to create any
  # /posts/:id routes, just posts/:post_id/comments routes
  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
  end
  # Comments are displayed in posts #show view so we don't need index or view
  # We won't give users ability to view individual comments or edits, so we don't need
  # to include show, update, or edit routes
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  root 'welcome#index'

  get 'welcome/contact'
end
