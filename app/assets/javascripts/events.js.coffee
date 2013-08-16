highlight = new EventSource('/highlight')

highlight.addEventListener 'message', (e) ->
  snippet = JSON.parse(e.data)
  $snippet = $("#snippet_#{snippet.id}")
  $snippet.find('code').html(snippet.pygment)
