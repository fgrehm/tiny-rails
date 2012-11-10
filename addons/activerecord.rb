gem 'activerecord', '~> 3.2'
gem 'sqlite3'

template 'activerecord/models.rb', 'models.rb'
require_models_code = <<-CODE
  # Enable code reloading for models
  require_dependency 'models'
CODE
inject_into_file 'tiny_rails_controller.rb', "\n#{require_models_code}", :after => /class TinyRailsController < ActionController::Base/

config_db_code = <<-CODE
  def config.database_configuration
    {
      'development' =>
        {
          'adapter'  => 'sqlite3',
          'database' => 'db.sqlite3',
          'pool'     => 5,
          'timeout'  => 5000
        }
    }
  end
CODE
application "\n#{config_db_code}"

template 'activerecord/migrate', 'migrate'
chmod 'migrate', 0755

append_to_file '.gitignore', 'db.sqlite3'
