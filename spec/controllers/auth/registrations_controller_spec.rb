require 'spec_helper'

describe Auth::RegistrationsController, type: :controller do
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
    let(:user_attrs) { attributes_for(:user, username: nil) }

    subject { post :create, params: { user: user_attrs } }

    include_context :user_should_be_logged_out

    it 'should redirect to edit profile page' do
      subject
      expect(response).to redirect_to edit_profile_path
    end

    it 'should create a new user' do
      expect { subject }.to change { User.count }
    end
  end
end
