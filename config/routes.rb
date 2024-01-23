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
    # ルート画面
    root to: 'homes#top'
    # 退会確認画面
    get '/users/check' => 'users#check', as: 'check'
    # 退会処理(ステータス更新)
    patch '/users/withdrawal' => 'userss#withdrawal', as: 'withdrawal'
    # ユーザー機能
    resources :users, only: [:show, :edit, :update] do
      # フォロー機能
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    # 楽曲投稿
    resources :post_musics do
      # コメント機能
      resources :post_comments, only: [:create, :destroy]
      # お気に入り機能
      resource :favorite, only: [:create, :destroy]
      get 'favorite', to: 'favorites#index', on: :member
    end
    # 検索機能
    resources :searches, only: :index, as: :search
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end















