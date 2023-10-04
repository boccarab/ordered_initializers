require 'rails'
require "ordered_initializers"

module OrderedInitializers
  class Railtie < ::Rails::Railtie
    def load_initializer_file
      OrderedInitializers.initializer_files = Parser.new.initializer_files
    end

    private

    config.before_initialize do
      load_initializer_file

      OrderedInitializers.go
    rescue Errno::ENOENT => e
      Rails.logger.info("Missing initializers.yml in config folder. Skip ordered_initializers")
    end
  end
end
