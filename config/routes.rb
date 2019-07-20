Rails.application.routes.draw do
  root 'welcome#index'

  resource :profile, only: %i[edit update]

  namespace :auth, path: '' do
    resource :password_reset, only: %i[new create edit update]

    resource :registration, only: [], path: '' do
      get    :new,     path: 'signup',  as: 'new'
      post   :create,  path: 'signup'
    end

    resource :session, only: [], path: '' do
      get    :new,     path: 'signin',  as: 'new'
      post   :create,  path: 'signin'
      delete :destroy, path: 'signout', as: 'destroy'
    end
  end
end
