require "ordered_initializers"

RSpec::Mocks.configuration.allow_message_expectations_on_nil = true

RSpec.configure do |config|
  # Reinit OrderedInitializers.initializer_files value
  config.before { OrderedInitializers.initializer_files = nil }
  config.after { OrderedInitializers.initializer_files = nil }
end
