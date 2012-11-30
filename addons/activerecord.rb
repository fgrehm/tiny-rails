gem 'activerecord', '~> 3.2'
gem 'sqlite3'

template 'activerecord/models.rb', 'models.rb'

require_models_code = <<-CODE
  # Enable code reloading for models
  require_dependency 'models'
CODE
inject_into_file 'application_controller.rb', "\n#{require_models_code}", :after => /class ApplicationController < ActionController::Base/

application <<-CODE
  # We need to override the configuration method here, otherwise Rails will
  # try to load the yaml configuration file at config/database.yml
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

inject_into_file 'boot.rb', "\nrequire \"active_record/railtie\"", :after => /require ['"]action_controller\/railtie['"]/

template 'activerecord/migrate', 'migrate'
chmod 'migrate', 0755

append_to_file '.gitignore', 'db.sqlite3'
