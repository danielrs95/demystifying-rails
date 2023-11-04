Rails.application.routes.draw do
  get '/hello_world' => 'application#hello_world'

  ### posts ###

  # get    '/posts'          => 'posts#index'
  # get    '/posts/new'      => 'posts#new'
  # get    '/posts/:id'      => 'posts#show'
  # post   '/posts'          => 'posts#create'
  # get    '/posts/:id/edit' => 'posts#edit'
  # patch  '/posts/:id'      => 'posts#update'
  # put    '/posts/:id'      => 'posts#update'
  # delete '/posts/:id'      => 'posts#destroy'

  ### comments ###

  # get    '/comments' => 'comments#index'
  # post   '/posts/:id/comments' => 'comments#create'
  # delete '/posts/:post_id/comments/:id' => 'comments#destroy'

  resources :posts do
    resources :comments, only: %i[create destroy]
  end
end
