require "bundler/gem_tasks"

begin
	require 'rspec/core/rake_task'
	RSpec::Core::RakeTask.new do |t|
		t.pattern = "spec/**/*_spec.rb"
	end
	task :default => :spec
rescue LoadError; end
