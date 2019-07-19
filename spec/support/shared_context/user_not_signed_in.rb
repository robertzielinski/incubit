shared_context :user_not_signed_in do
  context 'when user is not signed in' do
    it 'should redirect to login page' do
      logout
      subject
      expect(response).to redirect_to new_auth_session_path
    end
  end
end
