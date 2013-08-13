module SnippetsHelper
  def pygment_for(snippet)
    if snippet.pygment?
      content_tag :code, snippet.pygment.html_safe
    else
      content_tag :code, content_tag(:pre, snippet.content)
    end
  end
end
