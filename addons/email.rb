gem 'actionmailer', '~> 3.2'
gem 'letter_opener'
gem 'nokogiri'
gem 'premailer-rails3'

require_mailers_code = <<-CODE
  # Enable code reloading for mailers
  require_dependency 'mailers'
CODE
inject_into_file 'application_controller.rb', "\n#{require_mailers_code}", :after => /class ApplicationController < ActionController::Base/

application "  config.action_mailer.delivery_method = :letter_opener\n"

inject_into_file 'boot.rb', "\nrequire \"action_mailer/railtie\"", :after => /require ['"]action_controller\/railtie['"]/

template 'actionmailer/mailers.rb', 'mailers.rb'
template 'actionmailer/test_mail.html.erb', 'test_mail.html.erb'
