class Auth::BaseController < ApplicationController
  before_action :user_not_signed_in!

  private

  def user_not_signed_in!
    redirect_to root_path if user_signed_in?
  end
end
