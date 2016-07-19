Lctv::Application.routes.draw do

  get  '/signin'                  , :to => 'sessions#new'     , :as => :signin
  get  '/signout'                 , :to => 'sessions#destroy' , :as => :signout
  post '/auth/:provider/callback' , :to => 'sessions#create'
  get  '/auth/failure'            , :to => 'sessions#fail'

  get    'users'            => 'users#index'   , :as => 'users'
  get    'users/:nick'      => 'users#show'    , :as => 'user'
  get    'users/:nick/edit' => 'users#edit'    , :as => 'edit_user'
  patch  'users/:nick'      => 'users#update'
  put    'users/:nick'      => 'users#update'
  delete 'users/:nick'      => 'users#destroy'

  resources :projects

  root :controller => 'home' , :action => 'home'

  get 'badges'    => 'home#badges'
  get 'emoticons' => 'home#emoticons'

end
