shared_context :user_should_be_logged_out do
  context 'when user is signed in' do
    it 'should redirect to root page' do
      login_as(user)
      subject
      expect(response).to redirect_to root_path
    end
  end
end
