module SessionsHelper
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def user_signed_in?
    current_user.present?
  end

  def login_as(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end
end
