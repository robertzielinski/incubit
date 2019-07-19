require 'spec_helper'

describe ProfilesController, type: :controller do
  let(:user) { create(:user) }

  before do
    login_as(user)
  end

  describe 'GET edit' do
    subject do
      get :edit
    end

    include_context :user_not_signed_in

    it 'should be successful' do
      subject
      expect(response).to have_http_status(:successful)
      expect(response).to render_template :edit
    end
  end

  describe 'POST update' do
    subject do
      post :update, params: { user: { email: user.email, password: user.password } }
    end

    include_context :user_not_signed_in

    it 'should be successful' do
      subject
      expect(response).to have_http_status(:successful)
      expect(response).to render_template :edit
    end
  end
end
