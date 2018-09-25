Rails.application.routes.draw do
  root to: "concerns#top"
  resources :concerns do
    collection do
      post :confirm
    end
    resources :comments do
      resources :likes, only: [:create, :destroy, :edit, :update]
    end
  end

  resources :conversations do
    resources :messages
  end

  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only:[:new, :create, :destroy]
  resources :favorites, only:[:create, :destroy]
end
