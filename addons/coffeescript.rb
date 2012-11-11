enable_asset_pipeline!

gem 'coffee-rails'
gem 'therubyracer'

create_file 'application.coffee', '#= require_self'
# TODO: Add support for slim and haml
inject_into_file 'index.html.erb', "\n    <%= javascript_include_tag 'application' %>\n  ", :before => '</head>'
