class UsersController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.create! resource_params
    @user.send_registration_email

    render json: @user, status: :ok
  end

  def update
    user.update! resource_params

    head :no_content
  end

  def destroy
    user.destroy!

    head :no_content
  end

  private

  def resource_params
    params.require(:user).permit :name, :email, :date_of_birth,
                                 :password, :password_confirmation
  end

  def user
    @user ||= User.find params[:id]
  end
end
