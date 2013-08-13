$(document).on 'input', '#snippet_filename', (e) ->
  return unless @value.match /\..+/

  $.ajax
    type: 'GET'
    url: '/lexers'
    data: { filename: @value }
    success: (lexer) ->
      return unless lexer
      snippet_language.value = lexer.language

$(document).on 'submit', '#new_snippet', (e) ->
  e.preventDefault()
  $errors = $('p.errors')

  $errors.removeClass('visible')

  filename = snippet_filename.value
  language = snippet_language.value
  content  = snippet_content.value

  errors = []
  errors.push "filename can't be blank" if filename.match(/^\s*$/)
  errors.push "language can't be blank" if language.match(/^\s*$/)
  errors.push "content can't be blank"  if content.match(/^\s*$/)

  unless errors.length is 0
    $errors.text(errors.join(' and ')).addClass('visible')
    return

  $.ajax
    type: 'POST'
    url: '/snippets'
    data: $(this).serialize()
    beforeSend: (xhr) =>
      xhr.cid = Date.now()
      $filename = $('<p>').html("<strong>#{filename}</strong>")
      $content  = $('<code>').html("<pre>#{content}</pre>")
      $snippet  = $("<article id='#{xhr.cid}'>").html([$filename, $content])
      $(this).siblings('section').prepend($snippet)
      @reset()
    success: (snippet, status, xhr) =>
      $("##{xhr.cid}").replaceWith(snippet)
