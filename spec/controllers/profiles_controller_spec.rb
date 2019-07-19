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

    include_context :user_should_be_logged_in

    it 'should be successful' do
      subject
      expect(response).to have_http_status(:successful)
      expect(response).to render_template :edit
    end
  end

  describe 'POST update' do
    let(:user_attrs) { attributes_for(:user) }

    subject do
      post :update, params: { user: user_attrs }
    end

    include_context :user_should_be_logged_in

    it 'should redirect to edit profile page' do
      subject
      expect(response).to redirect_to edit_profile_path
    end
  end
end
