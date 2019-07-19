require 'spec_helper'

describe WelcomeController, type: :controller do
  describe '#INDEX' do
    it 'should be successful' do
      get :index
      expect(response).to be_success
      expect(response).to render_template :index
    end
  end
end
