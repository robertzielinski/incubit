require 'spec_helper'

describe Auth::SessionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET new' do
    it 'should be successful' do
      get :new
      expect(response).to be_success
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    it 'should redirect to root page' do
      post :create, params: { email: user.email, password: user.password }
      expect(response).to redirect_to root_path
    end
  end

  describe 'DELETE destroy' do
    it 'should redirect to new session page' do
      login_as(user)
      delete :destroy
      expect(response).to redirect_to new_auth_session_path
    end
  end
end
