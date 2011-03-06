
module Stupa
  class StupaError < StandardError
    attr_reader :data
    
    def initialize(data)
      @data = data
      super
    end
  end
  
  class StupaServerError < StupaError; end
  class StupaClientError < StupaError; end
end
