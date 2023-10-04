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

    Rails.application = double(:application)
  end

  after do
    Rails.application = nil
  end

  context "before_initialize" do
    before do
      allow(OrderedInitializers::Parser).to receive(:path).and_return(path)
    end

    context "when the initializers.yml file is present" do
      let(:path) { 'initializers.yml' }

      it "calls OrderedInitializer.go" do
        expect(OrderedInitializers::Railtie.instance).to receive(:load_initializer_file).and_call_original
        expect(OrderedInitializers).to receive(:go)

        ActiveSupport.run_load_hooks(:before_initialize)
      end
    end

    fcontext "when the initializers.yml file is missing" do
      let(:path) { 'foobar.yml' }

      it "does not call OrderedInitializer.go" do
        expect(OrderedInitializers::Railtie.instance).to receive(:load_initializer_file).and_call_original
        expect(OrderedInitializers).not_to receive(:go)

        expect(Rails.logger).to receive(:info).with(/Skip ordered_initializers/)

        ActiveSupport.run_load_hooks(:before_initialize)
      end
    end
  end
end
