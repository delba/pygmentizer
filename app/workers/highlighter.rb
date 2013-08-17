class Highlighter
  @queue = :snippets_queue

  def self.perform(snippet_id)
    Snippet.find(snippet_id).instance_exec do
      lexer = Pygments::Lexer.find_by_name(language)
      update!(pygment: lexer.highlight(content))
    end
  end
end
