Rails.application.routes.draw do
  root 'contacts#search'

  get 'contacts/index'
  get 'contacts/new'
  get 'contacts/edit'
  get 'contacts/show'
  get 'contacts/delete'
  resources :contacts do
    collection do
      post :import
      get :database
    end
  end

  resources :km do
    collection do
      get :roles
    end
  end
end
