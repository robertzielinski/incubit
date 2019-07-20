class Auth::PasswordResetsController < Auth::BaseController
  before_action :load_user, only: %i[edit update]
  before_action :authenticate_via_token!, only: %i[edit update]

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

  def edit; end

  def update
    if password_not_empty? && @user.update(user_params)
      redirect_to new_auth_session_path, notice: 'Password changed!'
    else
      flash.now[:alert] = 'Something went wrong!'
      render 'edit'
    end
  end

  private

  def authenticate_via_token!
    return if @user&.authenticate_via_token(params[:token])

    flash[:alert] = 'Wrong link, ask for new one filling the form below.'
    redirect_to new_auth_password_reset_url
  end

  def load_user
    @user = User.find_by_email(params[:email])
  end

  def password_not_empty?
    params[:user][:password].present?
  end

  def user_params
    params.require(:user).
      permit(:email, :password, :password_confirmation)
  end
end
