require 'spec_helper'

describe User do
  let(:user_build) { build(:user) }

  describe 'validations' do
    subject { user_build }

    context '#email' do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
      it { should allow_value('right@email.com').for(:email) }
      it { should_not allow_value('wrong@email').for(:email) }
      it { should_not allow_value('wrong.email').for(:email) }
    end

    context '#password' do
      it { should validate_length_of(:password).is_at_least(8) }
    end

    context '#username' do
      it { should_not validate_presence_of(:username).on(:create) }
      it { should validate_presence_of(:username).on(:update) }
      it { should validate_length_of(:username).is_at_least(5).on(:update) }

      it 'should not validate if username shorted than 5 but did not change' do
        user_build.email = 'user@gmail.com'
        user_build.save!
        expect(user_build).to be_valid
      end
    end
  end

  describe '#regenerate_password_reset_token' do
    let!(:user) { create(:user) }

    subject do
      user.regenerate_password_reset_token
    end

    it 'should regenerate password reset token' do
      expect { subject }.to change {
        user.password_reset_token_digest
      }.from(NilClass).to(String)
    end

    it 'should set new password reset sent at' do
      expect { subject }.to change {
        user.password_reset_sent_at
      }.from(NilClass).to(ActiveSupport::TimeWithZone)
    end

    it 'sends a reset passsword email' do
      expect { subject }.to change {
        ActionMailer::Base.deliveries.count
      }.by(1)
    end
  end

  describe '#send_welcome_message' do
    it 'sends a welcome email on create' do
      expect { user_build.save! }.to change {
        ActionMailer::Base.deliveries.count
      }.by(1)
    end

    it 'does not send a welcome email on update' do
      user_build.save!
      expect { user_build.save! }.to change {
        ActionMailer::Base.deliveries.count
      }.by(0)
    end
  end

  describe '#set_username' do
    context 'user is new' do
      it 'should set username as email prefix' do
        user_build.email = 'user@gmail.com'
        user_build.save!
        expect(user_build.username).to eq 'user'
      end
    end

    context 'user persisted' do
      it 'should not set new username' do
        user_build.email = 'user@gmail.com'
        user_build.save!
        user_build.email = 'new_user@gmail.com'
        user_build.save!
        expect(user_build.username).to eq 'user'
      end
    end
  end
end
