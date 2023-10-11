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

  describe "before_initialize" do
    before do
      allow(OrderedInitializers::Parser).to receive(:path).and_return(path)
    end

    context "when the initializers.yml file is present" do
      let(:path) { "initializers.yml" }

      it "calls OrderedInitializers.go" do
        expect(described_class.instance).to receive(:load_initializer_file).and_call_original
        expect(OrderedInitializers).to receive(:go)

        ActiveSupport.run_load_hooks(:before_initialize)
      end
    end

    fcontext "when the initializers.yml file is missing" do
      let(:path) { "foobar.yml" }

      it "does not call OrderedInitializers.go" do
        expect(described_class.instance).to receive(:load_initializer_file).and_call_original
        expect(OrderedInitializers).not_to receive(:go)

        expect(::Kernel).to receive(:warn).with(/Skipping ordered_initializers/)

        ActiveSupport.run_load_hooks(:before_initialize)
      end
    end
  end

  describe "#load_initializer_file" do
    subject(:load_initializer_file) { described_class.instance.load_initializer_file }

    it "sets OrderedInitializers.initializer_files" do
      allow(described_class.instance).to receive(:parsed).and_return(["fileA.rb", "fileB.rb", "fileC.rb"])

      load_initializer_file

      expect(OrderedInitializers.initializer_files).to eq(["fileA.rb", "fileB.rb", "fileC.rb"])
    end
  end
end
