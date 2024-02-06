Rails.application.routes.draw do
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions',
    registrations: 'admin/registrations'
  }
  # 管理者ゲストログイン
  devise_scope :admin do
    post 'admin/guest_sign_in', to: 'admin/sessions#guest_sign_in'
  end
  # namespace
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
  end
  
  # ユーザー用
  # URL /usees/s/sign_in 
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # namespace
  scope module: :public do
    root to: 'homes#top'
    get '/users/check' => 'users#check', as: 'check'
    patch '/users/withdrawal' => 'userss#withdrawal', as: 'withdrawal'
    resources :users, only: [:show, :index, :edit, :update] do
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
    resources :notifications, only: [:index, :update, :destroy] 
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end





























