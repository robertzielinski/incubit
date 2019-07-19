require 'spec_helper'

describe WelcomeController, type: :controller do
  describe 'GET index' do
    subject do
      get :index
    end

    context 'user signed in' do
      let(:user) { create(:user) }

      before do
        login_as(user)
      end

      it 'should be successful' do
        subject
        expect(response).to be_success
        expect(response).to render_template :index
      end
    end

    context 'user not signed in' do
      it 'should redirect to login page' do
        subject
        expect(response).to redirect_to new_auth_session_path
      end
    end
  end
end
