require 'spec_helper'

describe TinyRails::Commands::Add do
  before do
    Dir.exist?('.tmp') ? FileUtils.rm_rf('.tmp/*') : Dir.mkdir('.tmp')
    @original_wd = Dir.pwd
    FileUtils.cd '.tmp'
    %w(.gitignore tiny_rails_controller.rb boot.rb Gemfile).each do |file|
      `touch #{file}`
    end
  end

  after { FileUtils.cd @original_wd }

  let(:output) do
    fixtures_path = "#{@original_wd}/spec/fixtures"
    fixtures = %W( #{fixtures_path}/sample_addon_1.rb ../spec/fixtures/sample_addon_2.rb )
    bundled_addon = 'activerecord'
    output = capture(:stdout) { described_class.start([fixtures, bundled_addon].flatten) }
    output.gsub(/\e\[(\d+)m/, '')
  end

  it 'works with full path to file' do
    output.should =~ /gemfile\s+from-sample-addon-1/
  end

  it 'works with relative path to file' do
    output.should =~ /gemfile\s+from-sample-addon-2/
  end

  it 'works with bundled addons' do
    output.should =~ /gemfile\s+activerecord/
  end
end
