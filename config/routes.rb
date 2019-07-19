Rails.application.routes.draw do
  root 'welcome#index'

  namespace :auth, path: '' do
    resource :session, only: [], controller: 'sessions', path: '' do
      get    :new,     path: 'login',  as: 'new'
      post   :create,  path: 'login'
      delete :destroy, path: 'logout', as: 'destroy'
    end
  end
end
