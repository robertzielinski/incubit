shared_context :user_should_be_signed_in do
  context 'when user is not signed in' do
    it 'should redirect to signin page' do
      signout
      subject
      expect(response).to redirect_to new_auth_session_path
    end
  end
end
