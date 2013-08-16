class Snippet < ActiveRecord::Base
  LANGUAGES = Pygments.lexers.keys.sort

  validates :filename, :language, :content, presence: true

  validates :language, inclusion: { in: LANGUAGES }

  default_scope { order(created_at: :desc) }
end
