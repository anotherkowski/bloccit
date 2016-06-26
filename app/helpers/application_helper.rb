module ApplicationHelper
  def form_group_tag(errors, &block)
    # The & turns the block into a Proc, which is a block that can be used as a variable
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?

    content_tag :div, capture(&block), class: css_class
  end
end
