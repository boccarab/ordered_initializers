module OrderedInitializers
  class Parser
    def initializer_files
      YAML.load(yml_file, aliases: true)
    rescue ArgumentError
      YAML.load(yml_file)
    end

    private

    def yml_file
      File.read(Rails.root.join(path))
    end

    def path
      'config/initializers.yml'
    end
  end
end
