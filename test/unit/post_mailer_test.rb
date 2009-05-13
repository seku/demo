require 'test/test_helper'

class PostMailerTest < ActionMailer::TestCase
  
  def setup
    @user = User.new(:login => "janek")
  end
  
  def test_confirm
    response = PostMailer.create_confirm(@user)
    assert_equal("User confirm" , response.subject)
    assert_equal("ppp@ppp.pp" , response.to[0])
    assert_match(/Dear janek/, response.body)
    #assert_equal @expected.encoded, PostMailer.create_sent(@expected.date).encoded
  end
  
  def test_test
    response = PostMailer.create_test
    assert_equal("test", response.subject)
    assert_match(/test/, response.body)
  end
end

