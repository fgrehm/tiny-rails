require 'spec_helper'

describe TinyRails::CLI do
  before { FileUtils.rm_rf '.tmp' if Dir.exist?('.tmp') }

  context 'scaffold' do
    subject do
      output = capture(:stdout) { described_class.start(['.tmp']) }
      output.gsub(/\e\[(\d+)m/, '')
    end

    described_class.templates.each do |file|
      it { should =~ /create\s+#{Regexp.escape file}/ }
    end

    described_class.executables.each do |script|
      it { should =~ /chmod\s+#{Regexp.escape script}/ }
    end
  end
end
