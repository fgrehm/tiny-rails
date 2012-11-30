class TinyMailer < ActionMailer::Base
  append_view_path File.dirname(__FILE__)

  default from:          'no-reply@example.com',
          template_path: '.'

  def test_mail
    mail(to: 'user@example.com', subject: 'Testing mailer', template_name: 'test_mail')
  end
end
