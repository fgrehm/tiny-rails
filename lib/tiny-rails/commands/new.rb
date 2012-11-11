require 'fileutils'

module TinyRails
  module Commands
    class New < Thor::Group
      include Thor::Actions
      include Actions

      argument :app_path, :required => true

      # TODO: Move to a base command
      def self.source_root
        "#{File.expand_path('../../../../templates', __FILE__)}/"
      end

      def self.banner
        "tiny-rails new #{self.arguments.map(&:usage).join(' ')} [options]"
      end

      def self.templates
        @templates ||= %w(
          .gitignore
          Gemfile
          boot.rb
          application_controller.rb
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
end
