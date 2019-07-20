require 'spec_helper'

describe Auth::PasswordResetsController, type: :controller do
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
    let(:password_reset_attrs) do
      { email: user.email }
    end

    subject { post :create, params: { password_reset: password_reset_attrs } }

    include_context :user_should_be_logged_out

    context 'succeeded' do
      it 'should redirect to login page' do
        subject
        expect(response).to redirect_to new_auth_session_path
      end

      it 'should run regenerate password reset token method' do
        expect_any_instance_of(User).to receive(:regenerate_password_reset_token)
        subject
      end
    end

    context 'did not succeeded' do
      it 'should render new form' do
        password_reset_attrs[:email] = 'wrong@email.com'
        subject
        expect(response).to render_template :new
      end
    end
  end
end
