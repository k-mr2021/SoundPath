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
    resources :users, only: [:show, :edit, :update]
    resources :post_musics do
      resources :post_comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
      get 'favorite', to: 'favorites#index', on: :member
    end
    resources :searches, only: :index, as: :search
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end















