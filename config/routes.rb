Lctv::Application.routes.draw do

  # home
  root :controller => 'home' , :action => 'home'

  # auth
  get  '/signin'                  , :to => 'sessions#new'     , :as => :signin
  get  '/signout'                 , :to => 'sessions#destroy' , :as => :signout
  post '/auth/:provider/callback' , :to => 'sessions#create'
  get  '/auth/failure'            , :to => 'sessions#fail'

  # users
  get    'users'            => 'users#index'   , :as => 'users'
  get    'users/:nick'      => 'users#show'    , :as => 'user'
  get    'users/:nick/edit' => 'users#edit'    , :as => 'edit_user'
  patch  'users/:nick'      => 'users#update'
  put    'users/:nick'      => 'users#update'
  delete 'users/:nick'      => 'users#destroy'

  # projects
  resources :projects

  # polls
  resources :polls
  post '/polls/votes' , :to => 'votes#create' , :as => :vote

  # misc
  get 'forum'     => 'home#forum'
  get 'badges'    => 'home#badges'
  get 'emoticons' => 'home#emoticons'

end
