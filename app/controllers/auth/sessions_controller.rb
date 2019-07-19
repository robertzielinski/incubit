class Auth::SessionsController < Auth::BaseController
  def new; end

  def create
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      login_as(user)
      redirect_to root_url, notice: 'Logged in'
    else
      flash.now[:alert] = 'Email or password is invalid'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to new_auth_session_path, notice: 'Logged out'
  end
end
