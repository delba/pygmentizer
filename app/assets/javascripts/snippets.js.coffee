$(document).on 'input', '#snippet_filename', (e) ->
  return unless @value.match /\..+/

  $.ajax
    type: 'GET'
    url: '/lexers'
    data: { filename: @value }
    success: (lexer) ->
      return unless lexer
      snippet_language.value = lexer.language

String::isBlank = ->
  @match /^\s*$/

$(document).on 'submit', '#new_snippet', (e) ->
  e.preventDefault()
  $errors = $('p.errors')

  $errors.removeClass('visible')

  snippet =
    filename: snippet_filename.value
    language: snippet_language.value
    content:  snippet_content.value

  snippet.errors = for key, value of snippet when value.isBlank()
    "#{key} can't be blank"

  if snippet.errors.length
    $errors.text(snippet.errors.join(' and ')).addClass('visible')
    return

  $.ajax
    type: 'POST'
    url: '/snippets'
    data: $(this).serialize()
    beforeSend: (xhr) =>
      xhr.cid = Date.now()
      $filename = $('<p>').html("<strong>#{snippet.filename}</strong>")
      $content  = $('<code>').html("<pre>#{snippet.content}</pre>")
      $snippet  = $("<article id='#{xhr.cid}'>").html([$filename, $content])
      $(this).siblings('section').prepend($snippet)
      @reset()
    success: (snippet, status, xhr) =>
      $("##{xhr.cid}").replaceWith(snippet)
