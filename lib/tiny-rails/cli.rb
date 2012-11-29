require 'thor'
require 'thor/group'

require 'tiny-rails/actions'
require 'tiny-rails/commands/add'
require 'tiny-rails/commands/console'
require 'tiny-rails/commands/new'

module TinyRails
  class CLI < Thor
    include Thor::Actions

    desc 'new APP_PATH', 'Creates a new tiny Rails application'
    method_option :addons, :type => :array, :aliases => '-a', :default => []
    def new(app_path)
      Commands::New.start([app_path])
      add(options[:addons]) unless options[:addons].empty?
    end

    desc 'add [addons]', 'Configures addons on a generated tiny Rails application'
    def add(addons = [])
      addons = Array(addons)
      Commands::Add.start(addons)
    end

    desc 'console', 'Starts the tiny-rails console'
    def console
      Commands::Console.start
    end
  end
end
