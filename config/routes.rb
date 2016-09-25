Rails.application.routes.draw do
  root 'contacts#search'
  get 'contacts/index'
  get 'contacts/new'
  get 'contacts/edit'
  get 'contacts/show'
  get 'contacts/delete'
  get 'contacts/search'
  get 'contacts/database'
  resources :contacts do
    collection { post :import }
  end
end
