require 'thor'
require 'thor/group'

module TinyRails
  class CLI < Thor::Group
    include Thor::Actions

    def hello_world
      puts "Hello world!"
    end
  end
end
