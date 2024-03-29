# frozen_string_literal: true

require 'thor'

module Macdiff
  # Handle the global access such as configuration
  class App
    attr_reader :config

    def initialize
      @config = TTY::Config.new
      @config.filename = 'macdiff'
      @config.extname = '.yml'
      # @config.append_path Dir.pwd # Dir.home
      @config.append_path File.join(Dir.home, '.config')
      @config.write unless @config.exist?
      @config.read
    end

    def self.config
      @config ||= new.config
    end
  end
end
