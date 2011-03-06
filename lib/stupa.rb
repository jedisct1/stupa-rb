
module Stupa
  def self.configure
    yield self
    true
  end  
end

require 'stupa/errors'  
require 'stupa/client'

    
