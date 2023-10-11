#!/usr/bin/env rake

require "rspec/core/rake_task"

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color]
  t.verbose = false
end

path = File.expand_path(__dir__)
Dir.glob("#{path}/tasks/**/*.rake").each { |f| import f }

task default: [:spec]
