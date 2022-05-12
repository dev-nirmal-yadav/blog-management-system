# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    expose :user, build_params: :sign_up_params

    def create
      if user.save
        sign_in user
        redirect_to root_path, notice: t('.signed_up_successfully')
      else
        render :create, layout: false
      end
    end

    private

    def sign_up_params
      params.require(:user).permit(:email, :password, :first_name, :last_name, :password_confirmation)
    end
  end
end
