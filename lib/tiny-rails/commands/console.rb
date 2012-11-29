module TinyRails
  module Commands
    class Console < Thor::Group
      include Thor::Actions
      include Actions

      # TODO: Move to a base command
      def self.source_root
        "#{File.expand_path('../../../../templates', __FILE__)}/"
      end

      def guard_inside_tiny_rails_app
        unless File.exists?('boot.rb')
          puts "Can't start console from outside a TinyRails application, please change to a TinyRails application directory first.\n"
          exit(1)
        end
      end

      def start_console
        require './boot.rb'
        require 'rails/commands/console'
        Rails::Console.start(TinyRailsApp)
      end
    end
  end
end
