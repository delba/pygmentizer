require 'test_helper'

class SnippetsTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = Capybara.javascript_driver

    @ruby   = snippets(:ruby).tap(&:save)
    Highlighter.perform(@ruby.id)
    @coffee = snippets(:coffee).tap(&:save)
    Highlighter.perform(@coffee.id)
  end

  teardown do
    Capybara.use_default_driver
  end

  test "view all snippets" do
    visit '/'
    assert_selector 'article .highlight', exact: 2
  end

  test "find language" do
    visit '/'

    within '#new_snippet' do
      fill_in 'Filename', with: 'user.rb'
      sleep 0.1
      assert_equal 'Ruby', find_field('Language').value
      fill_in 'Filename', with: 'user.coffee'
      sleep 0.1
      assert_equal 'CoffeeScript', find_field('Language').value
    end
  end

  test "create snippet with valid params" do
    visit '/'

    within '#new_snippet' do
      fill_in 'Filename', with: 'user.rb'
      fill_in 'Content', with: 'class User; end'
      click_button 'Create Snippet'
    end

    assert_equal '/', current_path
    assert_selector 'article', exact: 3
    assert has_content? 'user.rb'
  end

  test "create snippet without valid params" do
    visit '/'

    within '#new_snippet' do
      click_button 'Create Snippet'
    end

    assert_selector 'p.errors'
  end
end
