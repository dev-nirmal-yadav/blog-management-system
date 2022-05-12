# frozen_string_literal: true

module PostsHelper
  def tag_list(post)
    post.tags.collect(&:name).join(', ')
  end
end
