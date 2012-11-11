addon 'activerecord'
addon 'coffeescript'
addon 'jquery'

gem 'client_side_validations'

sentinel = {:after => "#= require jquery\n"}
inject_into_file 'application.coffee', "#= require rails.validations\n", sentinel

initializer_code = <<-CODE
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  unless html_tag =~ /^<label/
    %{<div class="field_with_errors">\#{html_tag}<label for="\#{instance.send(:tag_id)}" class="message">\#{instance.error_message.first}</label></div>}.html_safe
  else
    %{<div class="field_with_errors">\#{html_tag}</div>}.html_safe
  end
end
CODE
initializer initializer_code
