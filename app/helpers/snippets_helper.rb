module SnippetsHelper
  def pygment_for(snippet)
    if snippet.pygment?
      snippet.pygment.html_safe
    else
      content_tag :pre, snippet.content
    end
  end
end
