require_relative "lib/ordered_initializers/version"

Gem::Specification.new "ordered_initializers" do |s|
  s.authors = ["Benjamin BOCCARA"]
  s.email = "boccarab@gmail.com"
  s.version = OrderedInitializers::VERSION
  s.description = s.summary = "Run your Rails application initializers file in the order you want."
  s.files = `git ls-files -- lib/*`.split("\n")
  s.files += ["LICENSE"]
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.extra_rdoc_files = ["README.md"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_path = "lib"

  s.homepage = "https://rubygems.org/gems/ordered_initializers"
  s.license = "MIT"

  s.add_dependency "railties", ">= 5.2", "< 8"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "appraisal"
  s.add_development_dependency "standard"
end
