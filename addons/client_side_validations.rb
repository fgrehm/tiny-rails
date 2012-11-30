addon 'activerecord'
addon 'coffeescript'
addon 'jquery'

gem 'client_side_validations'

sentinel = {:after => "#= require jquery\n"}
inject_into_file 'application.coffee', "#= require rails.validations\n", sentinel

initializer 'require "tiny-rails/app/initializers/client_side_validations"'
