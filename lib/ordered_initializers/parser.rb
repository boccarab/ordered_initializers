module OrderedInitializers
  class Parser
    class << self
      def path
        "config/initializers.yml"
      end
    end

    def initializer_files
      YAML.safe_load(yml_file, aliases: true)
    rescue ArgumentError
      YAML.safe_load(yml_file)
    end

    private

    def yml_file
      File.read(Rails.root.join(self.class.path))
    end
  end
end
