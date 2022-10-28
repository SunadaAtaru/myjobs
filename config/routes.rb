Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'homes#top'   #この行を記述
  resources :posts do
    resources :comments, only:[:create, :destroy]
  end
end
