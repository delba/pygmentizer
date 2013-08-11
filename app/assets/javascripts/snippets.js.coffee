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

  $('p.errors').remove()

  errors = []
  errors.push "filename can't be blank" if snippet_filename.value.match(/^\s*$/)
  errors.push "language can't be blank" if snippet_language.value.match(/^\s*$/)
  errors.push "content can't be blank"  if snippet_content.value.match(/^\s*$/)

  unless errors.length is 0
    $errors = $('<p class="errors">').text(errors.join(' and '))
    $(new_snippet).find('.inline-field').after($errors)
    return

  $.ajax
    type: 'POST'
    url: '/snippets'
    data: $(this).serialize()
    success: (snippet) =>
      $(this).siblings('section').prepend(snippet)
      @reset()
