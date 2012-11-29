require 'spec_helper'

describe TinyRails::Commands::Console do
  before do
    Dir.exist?('.tmp') ? FileUtils.rm_rf('.tmp/*') : Dir.mkdir('.tmp')
    @original_wd = Dir.pwd
    FileUtils.cd '.tmp'
    `touch boot.rb`

    class ::TinyRailsApp; end
    class ::Rails
      class Console
      end
    end

    Rails::Console.stub(:start)

    command = described_class.new
    @required_files = []
    command.stub(:require) do |file|
      @required_files << file
    end

    capture(:stdout) { command.invoke_all }
  end

  after { FileUtils.cd @original_wd }

  it 'requires boot.rb file' do
    @required_files.should include('./boot.rb')
  end

  it 'requires rails command' do
    @required_files.should include('rails/commands/console')
  end

  it 'starts rails console' do
    Rails::Console.should have_received(:start).with(TinyRailsApp)
  end
end
