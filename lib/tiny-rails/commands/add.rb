module TinyRails
  module Commands
    class Add < Thor::Group
      include Thor::Actions
      include Actions

      argument :addons, :required => true, :type => :array

      def self.banner
        "tiny-rails add #{self.arguments.map(&:usage).join(' ')}"
      end

      # TODO: Move to a base command
      def self.source_root
        "#{File.expand_path('../../../../templates', __FILE__)}/"
      end

      def self.bundled_addons_path
        @bundled_addons_path ||= "#{File.expand_path('../../../../addons', __FILE__)}"
      end

      def guard_inside_tiny_rails_app
        unless File.exists?('boot.rb')
          puts "Can't add addons to a non-TinyRails application, please change to a TinyRails application directory first.\n"
          exit(1)
        end
      end

      def apply_addon_scripts
        addons.each{ |script| addon(script) }
      end
    end
  end
end
