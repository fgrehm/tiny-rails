require 'spec_helper'

describe TinyRails::CLI do
  before do
    FileUtils.rm_rf '.tmp' if Dir.exist?('.tmp')
    @original_wd = Dir.pwd
  end

  after { FileUtils.cd @original_wd }

  context 'scaffold' do
    subject do
      output = capture(:stdout) { described_class.start(['.tmp']) }
      output.gsub(/\e\[(\d+)m/, '')
    end

    %w(
      .gitignore
      Gemfile
      boot.rb
      tiny_rails_controller.rb
      index.html.erb
      server
      config.ru
    ).each do |file|
      it { should =~ /create\s+#{Regexp.escape file}/ }
    end

    it { should =~ /chmod\s+server/ }
  end

  context 'add-ons' do
    subject do
      fixtures_path = "#{@original_wd}/spec/fixtures"
      fixtures = %W( #{fixtures_path}/sample_addon_1.rb spec/fixtures/sample_addon_2.rb )
      bundled_addon = 'activerecord'
      output = capture(:stdout) { described_class.start(['.tmp', "-a", fixtures, bundled_addon].flatten) }
      output.gsub(/\e\[(\d+)m/, '')
    end

    it 'works with full path to file' do
      subject.should =~ /gemfile\s+from-sample-addon-1/
    end

    it 'works with relative path to file' do
      subject.should =~ /gemfile\s+from-sample-addon-2/
    end

    it 'works with bundled addons' do
      subject.should =~ /gemfile\s+activerecord/
    end
  end
end
