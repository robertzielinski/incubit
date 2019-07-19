class User < ApplicationRecord
  has_secure_password

  before_create :set_username

  validates :email, presence: true, uniqueness: true

  private

  def set_username
    self.username = email.split('@').first
  end
end
