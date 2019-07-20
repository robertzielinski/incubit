class Auth::SessionsController < Auth::BaseController
  skip_before_action :user_not_logged_in!, only: %i[destroy]
  before_action :authenticate_user!, only: %i[destroy]

  def new; end

  def create
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      login_as(user)
      redirect_to root_url, notice: 'Logged in'
    else
      flash.now[:alert] = 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_auth_session_path, notice: 'Logged out'
  end
end
