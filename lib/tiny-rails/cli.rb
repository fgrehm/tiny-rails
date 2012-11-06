require 'thor'
require 'thor/group'

require 'fileutils'

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
        application.coffee
        application.scss
        boot.rb
        config.ru
        Gemfile
        index.html.haml
        migrate
        models.rb
        server
        tiny_rails_controller.rb
        .gitignore
      )
    end

    def self.executables
      @executables ||= %w(
        migrate
        server
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
      self.class.executables.each do |script|
        chmod script, 0755
      end
    end
  end
end
