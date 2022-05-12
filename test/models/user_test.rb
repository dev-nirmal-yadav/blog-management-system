# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'email, first_name, last_name, and password_confirmation must be present' do
    user = Fabricate.build(:user, email: nil, first_name: nil, last_name: nil, password_confirmation: nil)

    refute user.valid?
    assert user.errors[:email] == ["can't be blank", 'is invalid']
    assert user.errors[:first_name] == ["can't be blank"]
    assert user.errors[:last_name] == ["can't be blank"]
    assert user.errors[:password_confirmation] == ["can't be blank"]
  end

  test 'email must be valid' do
    user = Fabricate.build(:user, email: 'some invalid email')

    refute user.valid?
    assert user.errors[:email] == ['is invalid']
  end
end
