Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
   get '/users/sign_out' => 'devise/sessions#destroy'
 end

  root 'contacts#search'

  get 'contacts/index'
  get 'contacts/new'
  get 'contacts/edit'
  get 'contacts/show'
  get 'contacts/delete'
  get 'contacts/search'
  get 'contacts/database'
  resources :contacts do
    collection do
      post :import
    end
  end

  resources :km do
    collection do
      get :roles
      get :birthdays
    end
  end
end
