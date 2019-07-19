class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Account was successfully updated!'
    else
      flash[:alert] = 'Something went wrong! Account was not updated.'
    end
    render :edit
  end

  private

  def load_user
    @user = current_user
  end

  def user_params
    params.require(:user).
      permit(:username, :email, :password, :password_confirmation)
  end
end
