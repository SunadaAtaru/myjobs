Rails.application.routes.draw do
  devise_for :users
  resources :users, only:[:index, :show]  #この行を追加
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'homes#top'   
  resources :posts do
    resources :comments, only:[:create, :destroy]
    resource :favorites, only: [:create, :destroy]  
  end
end
