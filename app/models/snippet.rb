class Snippet < ActiveRecord::Base
  LANGUAGES = Pygments.lexers.keys.sort

  validates :filename, :language, :content, presence: true

  validates :language, inclusion: { in: LANGUAGES }

  default_scope { order(created_at: :desc) }

  after_update if: :pygment_changed? do
    $redis.publish 'highlight', self.to_json
  end

  before_update do
    self.changed.each do |attribute|
      $redis.publish "change:#{attribute}", self.to_json
    end
  end
end
