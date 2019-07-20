class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Account was successfully updated!'
      redirect_to edit_profile_path
    else
      flash.now[:alert] = 'Something went wrong! Account was not updated.'
      render :edit
    end
  end

  private

  def load_user
    @user = current_user
  end

  def user_params
    params.require(:user).
      permit(:username, :password, :password_confirmation)
  end
end
