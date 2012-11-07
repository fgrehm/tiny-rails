require 'spec_helper'

describe TinyRails::CLI do
  before { FileUtils.rm_rf '.tmp' if Dir.exist?('.tmp') }

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
end
