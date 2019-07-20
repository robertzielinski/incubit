class AuthMailer < ApplicationMailer
  def welcome_message(user)
    @user = user
    mail(to: user.email, subject: 'Welcome to Incubit!')
  end

  def password_reset_email(user, token)
    @token = token
    @user = user
    mail(to: user.email, subject: 'Reset password')
  end
end
