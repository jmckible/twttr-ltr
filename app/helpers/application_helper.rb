module ApplicationHelper
  include Twitter::Autolink

  # .dup because text from twitter gem is locked
  def twitter_format(text)
    auto_link(text.dup).html_safe
  end
end
