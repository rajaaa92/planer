class UsersController < ApplicationController

  before_filter :authenticate_user!

  expose(:user, attributes: :user_params) { current_user }

  def show
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
