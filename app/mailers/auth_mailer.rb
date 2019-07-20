class AuthMailer < ApplicationMailer
  def welcome_message(user)
    @user = user
    mail(to: user.email, subject: 'Welcome to Incubit!')
  end
end
