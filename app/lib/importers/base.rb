module Importers
  class Base
    attr_reader :file

    def initialize(opts = {})
      @file = opts[:file]
    end

    def import!
      raise NotImplementedError
    end
  end
end
