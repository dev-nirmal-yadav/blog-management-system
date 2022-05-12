# frozen_string_literal: true

module ApplicationHelper
  def inline_errors(object, attribute)
    return if object.errors[attribute].none?

    content_tag :p, object.errors[attribute].join(', '), class: 'text-red-500 text-xs italic'
  end

  def text_field_css(object, attribute)
    'border-red-500' if object.errors[attribute].any?
  end

  def flash_type_color(flash_type)
    case flash_type
    when 'alert' then 'bg-red-500'
    when 'notice' then 'bg-green-500'
    end
  end
end
