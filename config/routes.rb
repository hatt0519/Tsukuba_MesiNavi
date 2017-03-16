Rails.application.routes.draw do
  root :to => 'shops#index'
  resources 'shops'
  post 'shops/show_now_open'
  post 'shops/search'
  post 'shops/edit_categories'
  post 'shops/update_categories'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
end
