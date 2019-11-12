require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @post = @user.posts.build(title: 'New Title', body: 'Some message about someone secret')
  end

  test 'post should be valid' do
    assert @post.valid?
  end

  test 'title should be present' do
    @post.title = ''
    assert_not @post.valid?
  end

  test 'body should be present' do
    @post.body = ''
    assert_not @post.valid?
  end

  test 'user_id should be present' do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test 'title should not be too long' do
    @post.title = 'a' * 101
    assert_not @post.valid?
  end
end
