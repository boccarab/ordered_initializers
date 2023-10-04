require "ordered_initializers"

RSpec.configure do |config|
end

def fixture_path(name)
  File.join(File.expand_path("../fixtures", __FILE__), name)
end
