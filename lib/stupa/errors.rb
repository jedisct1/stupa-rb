
module Stupa
  class StupaError < StandardError
    attr_reader :data
    
    def initialize(data)
      @data = data
      super
    end
  end
  
  class StupaServerError < StandardError; end
  class StupaClientError < StandardError; end
end
