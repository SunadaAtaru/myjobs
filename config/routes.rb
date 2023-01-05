Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  resources :users, only:[:index, :show, :edit, :update,:destroy] do
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy] 
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'homes#top'   
  resources :posts do
    resources :comments,  only:[:create, :destroy]
    resource  :favorites, only: [:create, :destroy]  
  end
end
