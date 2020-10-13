Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # トップページにアクセスした時のルーティングをindexアクションに設定 
  root to: 'toppages#index'
  
  # ユーザ情報を新規作成
  # ユーザの新規登録URLを /signup に個別設定
  get 'signup', to: 'users#new'
  # 必要なアクションのみ指定
  resources :users, only: [:index, :show, :new, :create]
end
