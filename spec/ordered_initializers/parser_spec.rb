require 'spec_helper'

describe OrderedInitializers::Parser do
  let(:parser) { described_class.new }

  before do
    Dir.chdir(File.expand_path('../../fixtures', __FILE__))
    allow(Rails).to receive(:root).and_return Pathname.new(File.expand_path("../../fixtures", __FILE__))
  end

  describe '.initializer_files' do
    before do
      allow(described_class).to receive(:path).and_return('initializers.yml')
    end

    subject(:initializer_files) { parser.initializer_files }

    it 'returns parsed content as an Array' do
      expect(initializer_files).to eq(["file1.rb", "file2.rb", "file3.rb"])
    end
  end

  describe '.yml_file' do
    before do
      allow(described_class).to receive(:path).and_return('initializers.yml')
    end

    subject(:yml_file) { parser.send(:yml_file) }

    it 'returns content of yaml file' do
      expect(yml_file).to eq("- file1.rb\n- file2.rb\n- file3.rb\n")
    end
  end

  describe '#path' do
    subject(:path) { described_class.path }

    it 'returns the default path' do
      expect(path).to eq('config/initializers.yml')
    end
  end
end
