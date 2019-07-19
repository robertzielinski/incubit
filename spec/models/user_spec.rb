require 'spec_helper'

describe User do
  let(:user_build) { build(:user) }

  describe '#set_username' do
    context 'user is new' do
      it 'should set username as email prefix' do
        user_build.email = 'prefix@gmail.com'
        user_build.save!
        expect(user_build.username).to eq 'prefix'
      end
    end

    context 'user persisted' do
      it 'should not set new username' do
        user_build.email = 'prefix@gmail.com'
        user_build.save!
        user_build.email = 'new_prefix@gmail.com'
        user_build.save!
        expect(user_build.username).to eq 'prefix'
      end
    end
  end
end
