# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in @user = Fabricate(:user)
  end

  test 'get index' do
    get posts_path

    assert_response :success
  end

  test 'create post' do
    description = Faker::Lorem.paragraph
    valid_main_image = valid_image_file

    post posts_path, params: { post: { title: 'title', description: description, main_image: valid_main_image } }

    assert post = Post.last
    assert post.title == 'title'
    assert post.status == 'draft'
    assert post.user_id == @user.id
    assert_nil post.published_at
    assert post.description.to_plain_text == description
    assert post.main_image.signed_id == valid_main_image

    assert_redirected_to posts_path(own_posts: true)
  end

  test 'edit post' do
    post = Fabricate(:post, user: @user)

    get edit_post_path(post)
    assert_response :success
  end

  test 'update post' do
    post = Fabricate(:post, user: @user)
    description = Faker::Lorem.paragraph
    valid_main_image = valid_image_file

    patch post_path(post), params: { post: { title: 'title', description: description, main_image: valid_main_image } }

    assert post.reload.title == 'title'
    assert post.description.to_plain_text == description
    assert post.main_image.signed_id == valid_main_image

    assert_redirected_to post_path(post)
  end

  test 'destroy post and redirect to my posts page' do
    post = Fabricate(:post, user: @user)

    delete post_path(post)

    assert_nil Post.find_by_id(post.id)
    assert_redirected_to posts_path(own_posts: true)
  end

  test 'publish post' do
    post = Fabricate(:post, user: @user)

    put publish_post_path(post)

    assert post.reload.status == 'published'
    assert post.published_at
  end

  private

  def valid_image_file
    @valid_image_file ||= blob_for('valid_main_image.jpg').signed_id
  end

  def blob_for(name)
    ActiveStorage::Blob.create_and_upload!(
      io: File.open(Rails.root.join(file_fixture(name))),
      content_type: 'image/jpg',
      filename: name
    )
  end
end
