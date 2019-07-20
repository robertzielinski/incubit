class Auth::PasswordResetsController < Auth::BaseController
  def new; end

  def create
    user = User.find_by_email(params[:password_reset][:email].downcase)
    if user
      user.regenerate_password_reset_token
      flash[:notice] = 'Password reset instructions were sent to your email'
      redirect_to new_auth_session_path
    else
      flash.now[:alert] = 'User with given email address not found'
      render :new
    end
  end
end
