Rails.application.routes.draw do
  get 'users/index'=>"users#index"
  get "users/signup" =>"users#signup"
  get "users/login" =>"users#login_form"
  get "users/:id"=>"users#show"
  get "users/:id/edit" => "users#edit"
  post "login" => "users#login"
  post "logout" => "users#logout"
  post "users/create" =>"users#create"
  post "users/:id/update" => "users#update"
  post "users/:id/destroy" => "users#destroy"
  get 'posts/index' =>"posts#index"
  get "posts/new"=>"posts#new"
  get "posts/:id/edit"=>"posts#edit"
  post "posts/create"=>"posts#create"
  post "posts/:id/update"=>"posts#update"
  post "posts/:id/destroy"=>"posts#destroy"
  get "posts/:id" =>"posts#show"
  get '/' =>"home#top"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
