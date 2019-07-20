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
    let(:user_attrs) do
      { username: 'new_username' }
    end

    subject do
      post :update, params: { user: user_attrs }
    end

    include_context :user_should_be_logged_in

    context 'succeeded' do
      it 'should redirect to edit profile page' do
        subject
        expect(response).to redirect_to edit_profile_path
      end

      it 'should update username' do
        subject
        expect(user.reload.username).to eq 'new_username'
      end

      it 'should not update email' do
        user_attrs[:email] = 'new@email.com'
        old_email = user.email
        subject
        expect(user.reload.email).to eq old_email
      end
    end

    context 'did not succeeded' do
      it 'should render edit form' do
        user_attrs[:username] = 'a'
        subject
        expect(response).to render_template :edit
      end
    end
  end
end
