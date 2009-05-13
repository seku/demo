class PostMailer < ActionMailer::Base
  

  def confirm(user)
    subject    'User confirm'
    recipients "ppp@ppp.pp"
    from       'rails demo'
    sent_on    Time.now
    
    body       :user => user
  end

  def sent(sent_at = Time.now)
    subject    'PostMailer#sent'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end
  def test 
    subject "test"
    recipients "test@test"
    sent_on Time.now
  end
end
