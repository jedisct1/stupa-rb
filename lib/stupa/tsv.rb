
module TSV
  class << self
    def parse_rows(str)
      str.split("\n").collect { |row| row.split("\t") }
    end
    
    def parse_rows_key_and_score(str)
      rows = parse_rows(str)
      h = rows.collect do |row|
        [ row.first, row.last.to_f ]
      end
      Hash[*h.flatten]
    end
    
    def parse_rows_key_and_values(str)
      rows = parse_rows(str)    
      h = rows.collect do |row|
        [ row.first, row[1..-1] ]
      end
      Hash[*h.flatten(1)]
    end
    
    def join(values)
      raise TSVError, values unless joinable?(values) && ! values.empty?
      if values.respond_to?('join')
        values.join("\t")
      else
        values
      end
    end
    
    def joinable?(values)
      values = [ values ] unless values.kind_of?(Array)
      ! values.detect do |value|
        value.include?("\t") || value.include?("\n")
      end
    end
  end
  
  class TSVError < StandardError; end
end
