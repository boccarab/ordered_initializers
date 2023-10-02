module OrderedInitializers
  class Railtie < Rails::Railtie
    def load_initializer_file
      OrderedInitializers.initializer_files = yaml[Rails.env].as_json
    end

    private

    def yaml
      erb_result = ERB.new(yml_file.read).result
      YAML.load(erb_result, aliases: true)
    rescue ArgumentError
      YAML.load(erb_result)
    end

    def yml_file
      Rails.root.join('config', 'initializers.yml')
    end

    config.before_initialize do
      load_initializer_file

      OrderedInitializers.go
    rescue Errno::ENOENT => e
      Rails.logger.info("Missing initializers.yml in config folder. Skip ordered_initializers")
    end
  end
end
