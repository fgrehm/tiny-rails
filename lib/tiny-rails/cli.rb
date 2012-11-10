require 'thor'
require 'thor/group'

require 'tiny-rails/actions'
require 'tiny-rails/commands/new'

module TinyRails
  class CLI
    def self.start(args = ARGV)
      case args.shift
      when 'new'
        Commands::New.start(args)
      end
    end
  end
end
