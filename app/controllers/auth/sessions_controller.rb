class Auth::SessionsController < Auth::BaseController
  skip_before_action :user_not_signed_in!, only: %i[destroy]
  before_action :authenticate_user!, only: %i[destroy]

  def new; end

  def create
    verify_recaptcha!(fallback_action: :new) { return }

    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      signin_as(user)
      redirect_to root_url, notice: 'signed in'
    else
      flash.now[:alert] = 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    signout
    redirect_to new_auth_session_path, notice: 'signed out'
  end
end
