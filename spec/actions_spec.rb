require 'spec_helper'

describe TinyRails::Actions do
  let(:generator) do
    Class.new(Thor::Group) do
      include Thor::Actions
      include TinyRails::Actions
    end.new
  end

  def action(*args, &block)
    capture(:stdout) { generator.send(*args, &block) }
  end

  before do
    FileUtils.rm_rf '.tmp' if Dir.exist?('.tmp')
    @original_wd = Dir.pwd
    Dir.mkdir '.tmp'
    Dir.chdir '.tmp'
  end

  after { Dir.chdir @original_wd }

  describe '#gem' do
    let(:gemfile) { File.read 'Gemfile' }

    before  { action :create_file, 'Gemfile' }

    it 'adds gem dependency in Gemfile' do
      action :gem, 'will-paginate'
      gemfile.should =~ /gem "will\-paginate"/
    end

    it 'adds gem with version in Gemfile' do
      action :gem, 'rspec', '>=2.0.0.a5'
      gemfile.should =~ /gem "rspec", ">=2.0.0.a5"/
    end

    it 'inserts gems on separate lines' do
      File.open('Gemfile', 'a') {|f| f.write('# Some content...') }

      action :gem, 'rspec'
      action :gem, 'rspec-rails'

      gemfile.should =~ /^gem "rspec"$/
      gemfile.should =~ /^gem "rspec-rails"$/
    end

    it 'includes gem options' do
      action :gem, 'rspec', github: 'dchelimsky/rspec', tag: '1.2.9.rc1'
      gemfile.should =~ /gem "rspec", github: "dchelimsky\/rspec", tag: "1\.2\.9\.rc1"/
    end
  end

  describe '#application' do
    let(:boot_rb) { File.read 'boot.rb' }

    before { action :create_file, 'boot.rb', "class TinyRailsApp\n  config.secret_token = 'something'\nend" }

    it 'includes data in TinyRailsApp definition' do
      assets_enable = '  config.assets.enabled = true'
      action :application, assets_enable
      boot_rb.should =~ /class TinyRailsApp\n  config\.secret_token = 'something'\n\n#{Regexp.escape(assets_enable)}/
    end

    it 'includes provided block contents in TinyRailsApp definition' do
      action :application do
        '# This wont be added'
        '# This will be added'
      end

      boot_rb.should =~ /# This will be added/
      boot_rb.should_not =~ /# This wont be added/
    end
  end

  describe '#route' do
    let(:boot_rb) { File.read 'boot.rb' }

    before do
      action :create_file, 'boot.rb', "TinyRailsApp.routes.draw do\nend"
    end

    it 'includes data in routes definitions' do
      new_route = '  match "foo" => "tiny_rails#bar"'
      action :route, new_route
      boot_rb.should =~ /TinyRailsApp\.routes.draw do\n#{Regexp.escape(new_route)}end/
    end
  end

  describe '#enable_asset_pipeline!' do
    let(:boot_rb) { File.read 'boot.rb' }

    before do
      action :create_file, 'boot.rb', "class TinyRailsApp\n  config.secret_token = 'something'\nend"
      action :enable_asset_pipeline!
    end

    it 'enables asset pipeline on boot.rb' do
      boot_rb.should =~ /^  config\.assets\.enabled = true$/
    end

    it 'sets debugging to true' do
      boot_rb.should =~ /^  config\.assets\.debug   = true$/
    end

    it 'appends application root folder to assets path' do
      boot_rb.should =~ /^  config\.assets\.paths << File\.dirname\(__FILE__\)$/
    end

    it 'does not duplicate configs' do
      10.times { action :enable_asset_pipeline! }
      boot_rb.should have_a_single_occurence_of('config.assets.enabled = true')
    end
  end

  describe '#initializer' do
    let(:initializers_rb) { File.read 'initializers.rb' }
    let(:remote_code)     { StringIO.new('remote code') }

    before do
      action :initializer, '# Ruby code...'
      generator.stub(:open).and_yield(remote_code)
    end

    it 'creates an initializers.rb file if it doesnt exist' do
      initializers_rb.should == "# Ruby code..."
    end

    it 'appends to initializers.rb file if file exist' do
      action :initializer, '# More code...'
      initializers_rb.should =~ /\n# More code.../
    end

    it 'supports appending a remote file' do
      action :initializer, 'http://path.to/gist'
      initializers_rb.should =~ /\nremote code/
    end
  end

  describe '#migration' do
    let(:migrate) { File.read 'migrate' }

    before do
      action :create_file, 'migrate', "ActiveRecord::Schema.define do\nend"
      action :migration, '  create_table :users'
    end

    it 'appends to schema definition on migrate file' do
      migrate.should =~ /ActiveRecord::Schema.define do\n  create_table :users\nend/
    end
  end
end
