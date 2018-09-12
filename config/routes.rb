Rails.application.routes.draw do
  resources :concerns do
    collection do
      post :confirm
    end
    resources :comments
  end

  resources :conversations do
    resources :messages
  end
  
  resources :users, only: [:new, :create, :show, :edit, :update, :index]
  resources :sessions, only:[:new, :create, :destroy]
  resources :favorites, only:[:create, :destroy]
end
