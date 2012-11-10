require 'spec_helper'

describe TinyRails::Commands::Add do
  let(:addon) { StringIO.new('gem "sample-gem"') }

  before do
    Dir.exist?('.tmp') ? FileUtils.rm_rf('.tmp/*') : Dir.mkdir('.tmp')
    FileUtils.cp Dir["#{Dir.pwd}/spec/fixtures/sample_app/*"], '.tmp'
    @original_wd = Dir.pwd
    FileUtils.cd '.tmp'
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
