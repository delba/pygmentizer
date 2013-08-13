class Snippet < ActiveRecord::Base
  LANGUAGES = Pygments.lexers.keys.sort

  validates :filename, :language, :content, presence: true

  validates :language, inclusion: { in: LANGUAGES }

  before_save :set_pygment

  default_scope { order(created_at: :desc) }

private

  def set_pygment
    lexer = Pygments::Lexer.find_by_name(language)
    self.pygment = lexer.highlight(content)
  end
end
