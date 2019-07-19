shared_context :user_should_be_logged_in do
  context 'when user is not signed in' do
    it 'should redirect to login page' do
      logout
      subject
      expect(response).to redirect_to new_auth_session_path
    end
  end
end
