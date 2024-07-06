Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :hotels do
    collection do
      get 'my_hotels', to: 'hotels#my_hotels'
      get 'search', to: 'hotels#search'  # ここを追加
    end
    resources :reservations, only: [:new, :create, :show, :index, :edit, :update, :destroy]
  end

  resources :reservations, only: [:index]

  resource :account_settings, only: [] do
    collection do
      get 'show_account', to: 'account_settings#show_account'
      get 'edit_account', to: 'account_settings#edit_account'
      patch 'update_account', to: 'account_settings#update_account'
      get 'show_profile', to: 'account_settings#show_profile'
      get 'edit_profile', to: 'account_settings#edit_profile'
      patch 'update_profile', to: 'account_settings#update_profile'
    end
  end

  get 'home/index'

  # 既存のルーティング
  get 'hotels/index'
  get 'hotels/new'
  get 'hotels/create'
  get 'hotels/edit'
  get 'hotels/update'
  get 'hotels/show'
  get 'hotels/destroy'
end
