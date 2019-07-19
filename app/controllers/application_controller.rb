class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  before_action :set_response_format

  include SessionsHelper

  private

  def authenticate_user!
    redirect_to new_auth_session_path unless user_signed_in?
  end

  def set_response_format
    respond_to :html
  end
end
