require "ordered_initializers"

RSpec::Mocks.configuration.allow_message_expectations_on_nil = true

RSpec.configure do |config|
end

def fixture_path(name)
  File.join(File.expand_path("../fixtures", __FILE__), name)
end
