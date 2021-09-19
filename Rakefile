# frozen_string_literal: true

GEM_NAME = 'macdiff'

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'macdiff/version'

RSpec::Core::RakeTask.new(:spec)

require 'rake/extensiontask'

task build: :compile

Rake::ExtensionTask.new('macdiff') do |ext|
  ext.lib_dir = 'lib/macdiff'
end

task default: %i[clobber compile spec]


desc 'Publish the gem to RubyGems.org'
task :publish do
  system 'gem build'
  system "gem push #{GEM_NAME}-#{Macdiff::VERSION}.gem"
end

desc 'Remove old *.gem files'
task :clean do
  system 'rm *.gem'
end

task default: %i[clobber compile spec]
