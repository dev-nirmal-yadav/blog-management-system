# frozen_string_literal: true

class HomeController < ApplicationController
  expose :posts, lambda {
    Post.includes(:user, :tags).published.paginate(page: params[:page], per_page: 10)
  }

  def index
    render template: 'posts/index'
  end
end
