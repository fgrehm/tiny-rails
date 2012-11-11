addon 'coffeescript'

gem 'jquery-rails'

sentinel = {:before => '#= require_self'}
inject_into_file 'application.coffee', "#= require jquery\n", sentinel
