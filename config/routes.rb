Rails.application.routes.draw do
  resources :topics do
    resources :posts, except: [:index]
  end
  # we use only: [] because we don't want to create any
  # /posts/:id routes, just posts/:post_id/comments routes
  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end
  # Comments are displayed in posts #show view so we don't need index or view
  # We won't give users ability to view individual comments or edits, so we don't need
  # to include show, update, or edit routes
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :labels, only: [:show]

  get 'about' => 'welcome#about'

  root 'welcome#index'

  get 'welcome/contact'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show]
      resources :topics, only: [:index, :show]
    end
  end
end
