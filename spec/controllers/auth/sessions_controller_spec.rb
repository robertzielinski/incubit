require 'spec_helper'

describe Auth::SessionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET new' do
    it 'should be successful' do
      get :new
      expect(response).to have_http_status(:successful)
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    subject do
      post :create, params: { email: user.email, password: user.password }
    end

    it 'should login user' do
      subject
      expect(user_signed_in?).to be true
    end

    it 'should redirect to root page' do
      subject
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
