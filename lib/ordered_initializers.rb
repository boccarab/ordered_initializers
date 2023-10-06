require 'ordered_initializers/parser'

module OrderedInitializers
  class << self
    attr_accessor :initializer_files
  end

  module_function

  def go
    initializer_files.each do |file|
      load_config_initializer(file)
    end
  end

  def load_config_initializer(initializer)
    load initializer
  end
end
