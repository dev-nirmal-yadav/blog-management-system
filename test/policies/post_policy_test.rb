# frozen_string_literal: true

require 'test_helper'

class PostPolicyTest < ActiveSupport::TestCase
  test 'destroy succeeds for post user' do
    user = Fabricate.build(:user)
    post = Fabricate(:post, user: user)

    assert permit(:destroy, user, post)
  end

  test 'destroy fails for other user' do
    user = Fabricate.build(:user)
    post = Fabricate(:post)

    refute permit(:destroy, user, post)
  end

  test 'edit succeeds for post user' do
    user = Fabricate.build(:user)
    post = Fabricate(:post, user: user)

    assert permit(:edit, user, post)
  end

  test 'edit fails for other user' do
    user = Fabricate.build(:user)
    post = Fabricate(:post)

    refute permit(:edit, user, post)
  end

  test 'update succeeds for post user' do
    user = Fabricate.build(:user)
    post = Fabricate(:post, user: user)

    assert permit(:update, user, post)
  end

  test 'update fails for other user' do
    user = Fabricate.build(:user)
    post = Fabricate(:post)

    refute permit(:update, user, post)
  end

  private

  def permit(action, current_user, record)
    self.class.to_s.gsub(/Test/, '').constantize.new(current_user, record).public_send("#{action}?")
  end
end
