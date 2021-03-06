class User < ApplicationRecord
  has_secure_password

  before_create :set_username
  after_create :send_welcome_message

  validates :email, presence: true, uniqueness: true,
                    format: { with: EMAIL_REGEX,
                              message: 'format is invalid' }
  validates_length_of :password, minimum: 8, allow_blank: true
  validates :username, presence: true, on: :update
  validates_length_of :username, minimum: 5, on: :update, if: :username_changed?

  def authenticate_via_token(token)
    password_reset_token_digest == Digest::SHA1.hexdigest(token) &&
      password_reset_sent_at > Time.zone.now - 6.hours
  end

  def regenerate_password_reset_token
    reset_token = SecureRandom.hex(20)
    update_columns(password_reset_token_digest: Digest::SHA1.hexdigest(reset_token),
                   password_reset_sent_at: Time.zone.now)

    Auth::Mailer.password_reset_email(self, reset_token).deliver_now
  end

  private

  def send_welcome_message
    Auth::Mailer.welcome_message(self).deliver_now
  end

  def set_username
    self.username = email.split('@').first
  end
end
