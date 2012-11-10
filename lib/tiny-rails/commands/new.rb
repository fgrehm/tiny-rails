require 'fileutils'

module TinyRails
  module Commands
    class New < Thor::Group
      include Thor::Actions
      include Actions

      argument :app_path, :required => true

      # TODO: Think about a better name than addon
      class_option :addons, :type => :array,
        :aliases => '-a',
        :default => []

      def self.source_root
        "#{File.expand_path('../../../../templates', __FILE__)}/"
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

      def self.bundled_addons_path
        @bundled_addons_path ||= "#{File.expand_path('../../../../addons', __FILE__)}"
      end

      def normalize_addon_paths
        options[:addons].map! do |path|
          if File.exist? "#{self.class.bundled_addons_path}/#{path}.rb"
            "#{self.class.bundled_addons_path}/#{path}.rb"
          else
            File.expand_path(path)
          end
        end
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

      def apply_addon_scripts
        options[:addons].each { |script| apply script }
      end
    end
  end
end
