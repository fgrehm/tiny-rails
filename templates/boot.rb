$:.unshift Dir.pwd

require 'bundler'
Bundler.setup :default

require "rails"
require "rails/all"

Bundler.require :default

class TinyRailsApp < Rails::Application
  routes.append do
    match "/" => "tiny_rails#index"
    match "/favicon.ico", :to => proc {|env| [200, {}, [""]] }
  end

  config.consider_all_requests_local       = true

  config.active_support.deprecation = :log

  config.autoload_paths << config.root

  config.assets.enabled = true
  config.assets.debug = true
  config.assets.paths << File.dirname(__FILE__)


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

  config.middleware.delete "Rack::Lock"
  config.middleware.delete "ActionDispatch::Flash"
  config.middleware.delete "ActionDispatch::BestStandardsSupport"
  config.middleware.use Rails::Rack::LogTailer, "log/#{Rails.env}.log"

  # We need a secret token for session, cookies, etc.
  config.secret_token = "49837489qkuweoiuoqwehisuakshdjksadhaisdy78o34y138974xyqp9rmye8yrpiokeuioqwzyoiuxftoyqiuxrhm3iou1hrzmjk"
end

TinyRailsApp.initialize!
