require_relative "lib/ordered_initializers/version"

Gem::Specification.new "ordered_initializers" do |s|
  s.authors = ["Benjamin BOCCARA"]
  s.email = "boccarab@gmail.com"
  s.version = OrderedInitializers::VERSION
  s.description = s.summary = "Run your Rails application initializers file in the order you want."
  s.files = ["lib/ordered_initializers.rb", "lib/ordered_initializers/rails.rb"]
  s.homepage = "https://rubygems.org/gems/ordered_initializers"
  s.license = "MIT"

  s.add_dependency "railties", ">= 5.2", "< 8"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "appraisal"
  s.add_development_dependency "standard"
end
