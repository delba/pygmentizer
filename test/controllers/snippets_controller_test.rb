require 'test_helper'

class SnippetsControllerTest < ActionController::TestCase
  test "get :index" do
    get :index

    refute_nil assigns(:snippets)
    assert_template :index
  end

  test "post :create with valid params" do
    assert_difference 'Snippet.count' do
      xhr :post, :create, snippet: {
        filename: 'person.rb',
        language: 'Ruby',
        content: 'class Person; end'
      }
    end

    assert assigns(:snippet).persisted?
    assert_template partial: '_snippet'
  end

  test "post :create without valid params" do
    assert_raise ActiveRecord::RecordInvalid do
      xhr :post, :create, snippet: {
        filename: 'noname.rb'
      }
    end
  end

  test "get :lexers with a valid extension" do
    get :lexers, filename: 'hello.rb'

    assert_equal 'Ruby', JSON.parse(@response.body)['language']
  end

  test "get :lexers without a valid extension" do
    get :lexers, filename: 'hello.noname'
    assert_empty @response.body
  end
end
