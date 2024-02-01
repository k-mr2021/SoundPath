Rails.application.routes.draw do
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
  end
  
  # ユーザー用
  # URL /usees/s/sign_in 
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    root to: 'homes#top'
    get '/users/check' => 'users#check', as: 'check'
    patch '/users/withdrawal' => 'userss#withdrawal', as: 'withdrawal'
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    resources :post_musics do
      resources :post_comments, only: [:create, :destroy]
      # indexを表示するため別途'get'で取得
      resource :favorite, only: [:create, :destroy]
      get 'favorite', to: 'favorites#index', on: :member
    end
    resources :searches, only: :index, as: :search
    resources :notifications, only: [:index] do
      patch :read, on: :member
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end




















