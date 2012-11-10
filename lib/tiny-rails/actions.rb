module TinyRails
  # Kinda based on Rails' https://github.com/rails/rails/blob/master/railties/lib/rails/generators/actions.rb
  module Actions
    # Adds an entry into Gemfile for the supplied gem.
    #
    #   gem "rspec", group: :test
    #   gem "technoweenie-restful-authentication", lib: "restful-authentication", source: "http://gems.github.com/"
    #   gem "rails", "3.0", git: "git://github.com/rails/rails"
    def gem(*args)
      options = extract_options!(args)
      name, version = args

      # Set the message to be shown in logs. Uses the git repo if one is given,
      # otherwise use name (version).
      parts, message = [ name.inspect ], name
      if version ||= options.delete(:version)
        parts   << version.inspect
        message << " (#{version})"
      end
      message = options[:git] if options[:git]

      say_status :gemfile, message

      options.each do |option, value|
        parts << "#{option}: #{value.inspect}"
      end

      in_root do
        str = "gem #{parts.join(", ")}"
        str = "\n" + str
        append_file "Gemfile", str, :verbose => false
      end
    end

    # Adds a line inside the Application class on boot.rb.
    #
    #   application do
    #     "config.assets.enabled = true"
    #   end
    def application(data=nil, &block)
      sentinel = /class TinyRailsApp < Rails::Application/i
      data = block.call if !data && block_given?

      inject_into_file 'boot.rb', "\n  #{data}", :after => sentinel
    end

    # Self explanatory :P
    def enable_asset_pipeline!
      return if File.read('boot.rb') =~ /^  config\.assets\.enabled = true$/

      code = <<-CONFIG
  config.assets.enabled = true
  config.assets.debug   = true
  config.assets.paths << File.dirname(__FILE__)
CONFIG
      application "\n#{code}"
    end

    private

    # From ActiveSupport's Array#extract_options!
    def extract_options!(array)
      if array.last.is_a?(Hash) && array.last.instance_of?(Hash)
        array.pop
      else
        {}
      end
    end
  end
end
