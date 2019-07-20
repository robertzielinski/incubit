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

  shared_examples :should_validate_email_and_token do
    let(:reset_password_params) do
      { email: user.email, token: token }
    end
    let(:token) { SecureRandom.hex(20) }

    before do
      user.update_column(:password_reset_token_digest, Digest::SHA1.hexdigest(token))
      user.update_column(:password_reset_sent_at, Time.zone.now)
    end

    context 'should authenticate via token and email' do
      it 'passed wrong token' do
        reset_password_params[:token] = 'wrong'
        subject
        expect(response).to redirect_to new_auth_password_reset_path
      end

      it 'passed wrong email' do
        reset_password_params[:email] = 'wrong'
        subject
        expect(response).to redirect_to new_auth_password_reset_path
      end
    end
  end

  describe 'GET edit' do
    subject { get :edit, params: reset_password_params }

    include_examples :should_validate_email_and_token

    include_context :user_should_be_logged_out

    it 'should be successful' do
      subject
      expect(response).to have_http_status(:successful)
      expect(response).to render_template :edit
    end
  end

  describe 'POST update' do
    let(:user_attrs) { { password: 'a_new_password' } }

    subject do
      post :update, params: reset_password_params.merge(user: user_attrs)
    end

    include_examples :should_validate_email_and_token

    include_context :user_should_be_logged_out

    context 'succeeded' do
      it 'should redirect to login page' do
        subject
        expect(response).to redirect_to new_auth_session_path
      end
    end

    context 'did not succeeded' do
      before do
        user_attrs[:password] = 'wrong'
      end

      it 'should render edit form' do
        subject
        expect(response).to render_template :edit
      end
    end
  end
end
