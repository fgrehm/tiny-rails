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

    # Appends a line inside the TinyRailsApp class on boot.rb.
    #
    #   application do
    #     "config.assets.enabled = true"
    #   end
    def application(data=nil, &block)
      data = block.call if !data && block_given?

      data = "\n#{data}" unless data =~ /^\n/
      data << "\n" unless data =~ /\n$/

      inject_into_file 'boot.rb', data, :after => /^  config\.secret_token = .+\n/
    end

    def initializer(data)
      data = open(data) { |io| io.read } if data =~ /https?:\/\//

      if File.exists? 'initializers.rb'
        append_file 'initializers.rb', "\n#{data}"
      else
        create_file 'initializers.rb', data
      end
    end

    def migration(data)
      data << "\n" unless data =~ /\n$/

      inject_into_file 'migrate', data, :after => /^ActiveRecord::Schema\.define do\n/
    end

    def route(new_route)
      new_route << "\n" unless new_route =~ /\n$/

      inject_into_file 'boot.rb', new_route, :after => /routes.append do\n/
    end

    # Self explanatory :P
    def enable_asset_pipeline!
      return if File.read('boot.rb') =~ /^  config\.assets\.enabled = true$/

      application <<-CONFIG
  # Enable asset pipeline
  config.assets.enabled = true
  config.assets.debug   = true
  config.assets.paths << File.dirname(__FILE__)
CONFIG
    end

    def addon(path)
      path = if URI(path).is_a?(URI::HTTP)
        path
      elsif File.exist? "#{self.class.bundled_addons_path}/#{path}.rb"
        "#{self.class.bundled_addons_path}/#{path}.rb"
      else
        File.expand_path(path)
      end

      unless applied_addons.include?(path)
        applied_addons << path
        apply(path)
      end
    end

    private

    def applied_addons
      @applied_addons ||= []
    end

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
