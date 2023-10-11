require "rails"
require "ordered_initializers/parser"
require "ordered_initializers"

module OrderedInitializers
  class Railtie < ::Rails::Railtie
    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end

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
    rescue Errno::ENOENT
      ::Kernel.warn("Missing file #{Parser.path}! Please run `rake ordered_initializers:install` to generate the file. Skipping ordered_initializers for the moment")
    end
  end
end
