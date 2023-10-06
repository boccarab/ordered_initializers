require "spec_helper"

describe OrderedInitializers do
  describe '.go' do
    subject(:go) { OrderedInitializers.go }

    it 'calls load_config_initializer as many times as there are entry in initializer_files' do
      OrderedInitializers.initializer_files = Array.new(5)
      expect(OrderedInitializers).to receive(:load_config_initializer).exactly(5).times

      go
    end

    it 'raises an error if one initializer file is missing' do
      OrderedInitializers.initializer_files = ['foo.rb']

      expect { go }.to raise_error(LoadError, /cannot load such file -- foo.rb/)
    end
  end
end
