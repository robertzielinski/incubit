class Auth::BaseController < ApplicationController
  before_action :user_not_logged_in!

  private

  def user_not_logged_in!
    redirect_to root_path if user_signed_in?
  end
end
