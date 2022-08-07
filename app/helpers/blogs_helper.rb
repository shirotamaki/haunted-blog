# frozen_string_literal: true

module BlogsHelper
  def format_content(blog)
    simple_format(h(blog.content), {}, wrapper_tag: 'div')
  end
end
