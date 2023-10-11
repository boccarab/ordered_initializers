require 'rails'
require 'ordered_initializers/parser'
require "ordered_initializers"

module OrderedInitializers
  class Railtie < ::Rails::Railtie
    def load_initializer_file
      OrderedInitializers.initializer_files = parsed
    end

    def parsed
      Parser.new.initializer_files
    end

    private

    config.before_initialize do
      load_initializer_file

      OrderedInitializers.go
    rescue Errno::ENOENT => e
      Rails.logger.info("Missing file #{Parser.path}. Skip ordered_initializers")
    end
  end
end
