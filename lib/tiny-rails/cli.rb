require 'thor'
require 'thor/group'

require 'tiny-rails/actions'
require 'tiny-rails/commands/new'
require 'tiny-rails/commands/add'

module TinyRails
  class CLI
    def self.start(args = ARGV)
      case cmd = args.shift
      when 'new'
        Commands::New.start(args)
      when 'add'
        Commands::Add.start(args)
      else
        puts "\nUnknown command, available commands:\n  new\n  add"
        exit(1)
      end
    end
  end
end
