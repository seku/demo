require 'test/test_helper'

class EmailsControllerTest < ActionController::TestCase
  fixtures :users
  def setup
    @controller = EmailsController.new
    @request  = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @emails = ActionMailer::Base.deliveries
    @emails.clear
  end
  
  def test_confirm
    get :index
    assert_redirected_to(:action => :index)
    assert_equal(2, @emails.size)
    email = @emails.first
    assert_equal("User confirm" , email.subject)
    assert_equal("ppp@ppp.pp" , email.to[0])
    assert_match(/Dear janek/, email.body)

  end
end
