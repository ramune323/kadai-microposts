Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # トップページにアクセスした時のルーティングをindexアクションに設定 
  root to: 'toppages#index'
  
  # ログイン処理
  # 各ページのURLを個別指定
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # ユーザ情報を新規作成
  # ユーザの新規登録URLを /signup に個別設定
  get 'signup', to: 'users#new'
  # 必要なアクションのみ指定
  resources :users, only: [:index, :show, :new, :create] do
    # URLを生成する
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  # 投稿機能（新規投稿、削除）
  resources :microposts, only: [:create, :destroy]
  # フォロー／アンフォロー
  resources :relationships, only: [:create, :destroy]
  # お気に入り追加／削除
  resources :favorites, only: [:create, :destroy]
end
