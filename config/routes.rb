Rails.application.routes.draw do
  root 'welcome#index'

  resource :profile, only: %i[edit update]

  namespace :auth, path: '' do
    resource :password_reset, only: %i[new create edit update]

    resource :registration, only: [], path: '' do
      get    :new,     path: 'sign-up',  as: 'new'
      post   :create,  path: 'sign-up'
    end

    resource :session, only: [], path: '' do
      get    :new,     path: 'login',  as: 'new'
      post   :create,  path: 'login'
      delete :destroy, path: 'logout', as: 'destroy'
    end
  end
end
