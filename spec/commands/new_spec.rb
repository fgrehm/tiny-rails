require 'spec_helper'

describe TinyRails::Commands::New do
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
    it 'delegates addons arguments to Add comand' do
      TinyRails::Commands::Add.should_receive(:start).with(['addon-1', 'addon-2'])
      described_class.start(['.tmp', '-q', '-a', 'addon-1', 'addon-2'])
    end

    it 'does not invoke Add command if addons are suppressed' do
      TinyRails::Commands::Add.should_not_receive(:start)
      described_class.start(['.tmp', '-q'])
    end
  end
end
