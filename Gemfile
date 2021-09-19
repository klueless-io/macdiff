# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in poc_github_ap.gemspec
gemspec

# group :development do
#   # Currently conflicts with GitHub actions and so I remove it on push
#   # pry on steroids
#   gem 'jazz_fingers'
#   gem 'pry-coolline', github: 'owst/pry-coolline', branch: 'support_new_pry_config_api'
# end

group :development, :test do
  gem 'guard-bundler'
  gem 'guard-rspec'
  # pry on steroids
  gem 'rake', '~> 12.0'
  # this is used for cmdlets 'self-executing gems'
  gem 'rake-compiler'
  gem 'rspec', '~> 3.0'
  gem 'rubocop'
end
