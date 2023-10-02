Gem::Specification.new "ordered_initializers" do |s|
  s.authors     = ["Benjamin BOCCARA"]
  s.email       = "boccarab@gmail.com"
  s.version     = "0.1.0"
  s.description = s.summary = "Run your initializers in the order you want."
  s.files       = ["lib/ordered_initializers.rb", "lib/ordered_initializers/rails.rb"]
  s.homepage    = "https://rubygems.org/gems/ordered_initializers"
  s.license     = "MIT"

  s.add_dependency "railties", ">= 3.2"
end