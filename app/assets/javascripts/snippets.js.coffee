$(document).on 'input', '#snippet_filename', (e) ->
  return unless @value.match /\..+/

  $.ajax
    type: 'GET'
    url: '/lexers'
    data: { filename: @value }
    success: (lexer) ->
      return unless lexer
      snippet_language.value = lexer.language
