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
      application_controller.rb
      index.html.erb
      server
      config.ru
    ).each do |file|
      it { should =~ /create\s+#{Regexp.escape file}/ }
    end

    it { should =~ /chmod\s+server/ }
  end
end
