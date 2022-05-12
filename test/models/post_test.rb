# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'title, description, and user must be present' do
    post = Fabricate.build(:post, title: nil, description: nil, user: nil, main_image: nil)

    refute post.valid?
    assert post.errors[:user] == ['must exist']
    assert post.errors[:title] == ["can't be blank"]
    assert post.errors[:description] == ["can't be blank"]
  end

  test 'default status is draft' do
    post = Fabricate.build(:post)

    assert post.status == 'draft'
  end

  test 'scope own_posts returns posts of user' do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    post1 = Fabricate(:post, user: user1)
    post2 = Fabricate(:post, user: user1)
    post3 = Fabricate(:post, user: user2)
    post4 = Fabricate(:post, user: user2)

    assert Post.own_posts(user1).pluck(:id) == [post1.id, post2.id]
    assert Post.own_posts(user2).pluck(:id) == [post3.id, post4.id]
  end
end
