require 'test_helper'

class SnippetTest < ActiveSupport::TestCase
  test "snippets are ordered by date of creation reversed" do
    assert_equal Snippet.order(created_at: :desc), Snippet.all
  end
end
