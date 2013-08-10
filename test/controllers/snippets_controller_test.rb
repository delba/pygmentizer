require 'test_helper'

class SnippetsControllerTest < ActionController::TestCase
  test "get :index" do
    get :index

    refute_nil assigns(:snippets)
    assert_template :index
  end

  test "post :create with valid params" do
    assert_difference 'Snippet.count' do
      post :create, snippet: {
        filename: 'person.rb',
        language: 'Ruby',
        content: 'class Person; end'
      }
    end

    assert assigns(:snippet).persisted?
    assert_redirected_to root_url
  end

  test "post :create without valid params" do
    assert_no_difference 'Snippet.count' do
      post :create, snippet: {
        filename: 'noname.rb'
      }
    end

    assert assigns(:snippet).new_record?
    assert_template :index
  end
end
