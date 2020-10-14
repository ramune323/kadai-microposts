Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # トップページにアクセスした時のルーティングをindexアクションに設定 
  root to: 'toppages#index'
  
  # ユーザ情報を新規作成
  # ユーザの新規登録URLを /signup に個別設定
  get 'signup', to: 'users#new'
  
  # ログイン処理
  # 各ページのURLを個別指定
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # 必要なアクションのみ指定
  resources :users, only: [:index, :show, :new, :create]
  
  # 投稿機能（新規投稿、削除）
  resources :microposts, only: [:create, :destroy]
end
