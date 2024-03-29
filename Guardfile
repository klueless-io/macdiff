# frozen_string_literal: true

guard :bundler, cmd: 'bundle install' do
  watch('Gemfile')
  watch('macdiff.gemspec')
end

guard :rspec, cmd: 'bundle exec rspec -f doc' do
  require 'guard/rspec/dsl'
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)
  watch(%r{^lib/macdiff/(.+)\.rb$}) { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch(%r{^lib/macdiff/commands/(.+)\.rb$}) { |m| "spec/unit/commands/#{m[1]}_spec.rb" }
end
