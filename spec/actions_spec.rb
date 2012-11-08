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

    before  { action :create_file, 'boot.rb', "class TinyRailsApp < Rails::Application\nend" }

    it 'includes data in TinyRailsApp definition' do
      assets_enable = 'config.assets.enabled = true'
      action :application, assets_enable
      boot_rb.should =~ /class TinyRailsApp < Rails::Application\n  #{Regexp.escape(assets_enable)}/
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
end
