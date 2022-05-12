# frozen_string_literal: true

class UsersController < ApplicationController
  expose :user

  before_action :redirect_if_user_not_found

  def update
    if user.update(permitted_params)
      redirect_to root_path, notice: t('.user_details_updated_successfully')
    else
      render :edit
    end
  end

  private

  def redirect_if_user_not_found
    redirect_to root_path, alert: t('.record_not_found') unless user
  end

  def permitted_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :password_confirmation)
  end
end
