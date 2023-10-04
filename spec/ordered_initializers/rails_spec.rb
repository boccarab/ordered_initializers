require "spec_helper"
require "rails"
require "ordered_initializers/rails"

# Fake watcher for Spring
class SpecWatcher
  attr_reader :items

  def initialize
    @items = []
  end

  def add(*items)
    @items |= items
  end
end

describe OrderedInitializers::Railtie do
  before do
    Rails.env = "test"
    allow(Rails).to receive(:root).and_return Pathname.new(File.expand_path("../../fixtures", __FILE__))
    allow_any_instance_of(OrderedInitializers::Parser).to receive(:path).and_return('initializers.yml')

    Rails.application = double(:application)
    # Spring.watcher = SpecWatcher.new
  end

  after do
    # Reset
    # Spring.watcher = nil
    Rails.application = nil
  end

  context "before_initialize" do
    it "calls #load_initializer_file" do
      expect(OrderedInitializers::Railtie.instance).to receive(:load_initializer_file)
      expect(OrderedInitializers).to receive(:go)

      ActiveSupport.run_load_hooks(:before_initialize)
    end
  end
end
