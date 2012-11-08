require 'thor'
require 'thor/group'

require 'fileutils'

require 'tiny-rails/actions'

module TinyRails
  class CLI < Thor::Group
    include Thor::Actions

    argument :app_path, :required => true

    def self.source_root
      "#{File.expand_path('../../../templates', __FILE__)}/"
    end

    def self.banner
      "tiny-rails #{self.arguments.map(&:usage).join(' ')} [options]"
    end

    def self.templates
      @templates ||= %w(
        .gitignore
        Gemfile
        boot.rb
        tiny_rails_controller.rb
        index.html.erb
        server
        config.ru
      )
    end

    def create_root
      self.destination_root = File.expand_path(app_path)
      empty_directory '.'
      FileUtils.cd destination_root
    end

    def scaffold
      self.class.templates.each do |template|
        template(template)
      end
      chmod 'server', 0755
    end
  end
end
