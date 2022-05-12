# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'edit user' do
    user = Fabricate(:user)

    get edit_user_url(user), params: { user: { email: 'new@email.com' } }

    assert_response :success
  end

  test 'updates user with sent params and redirects to home page' do
    user = Fabricate(:user)
    update_params = {
      first_name: 'New First Name',
      last_name: 'New Last Name',
      email: 'new@email.com',
      password: 'password',
      password_confirmation: 'password'
    }

    patch user_url(user), params: { user: update_params }

    user.reload
    assert user.first_name == 'New First Name'
    assert user.last_name == 'New Last Name'
    assert user.email == 'new@email.com'
    assert_redirected_to root_path
  end

  test 'does not update user if passwords do not match' do
    user = Fabricate(:user)
    update_params = {
      first_name: 'New First Name',
      last_name: 'New Last Name',
      email: 'new@email.com',
      password: 'password',
      password_confirmation: 'another password'
    }

    patch user_url(user), params: { user: update_params }

    user.reload
    assert user.first_name != 'New First Name'
    assert user.last_name != 'New Last Name'
    assert user.email != 'new@email.com'
    assert_response :success
  end
end
