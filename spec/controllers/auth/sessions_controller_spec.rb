require 'spec_helper'

describe Auth::SessionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET new' do
    subject { get :new }

    include_context :user_should_be_logged_out

    it 'should be successful' do
      subject
      expect(response).to have_http_status(:successful)
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    let(:login_attrs) do
      { email: user.email, password: user.password }
    end

    subject do
      post :create, params: login_attrs
    end

    include_context :user_should_be_logged_out

    context 'succeeded' do
      it 'should login user' do
        subject
        expect(user_signed_in?).to be true
      end

      it 'should redirect to root page' do
        subject
        expect(response).to redirect_to root_path
      end
    end

    context 'did not succeeded' do
      it 'should render edit form' do
        login_attrs[:password] = 'wrong_password'
        subject
        expect(response).to render_template :new
      end
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
