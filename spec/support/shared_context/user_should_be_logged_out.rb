shared_context :user_should_be_signed_out do
  context 'when user is signed in' do
    it 'should redirect to root page' do
      signin_as(user)
      subject
      expect(response).to redirect_to root_path
    end
  end
end
