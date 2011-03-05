
require 'helper'
require 'tempfile'

class PersistenceTest < Test::Unit::TestCase
  context "a Stupa client with some data on the server" do
    setup do
      @client = Stupa::Client.new
      @client.clear
      @client.add('key1' => ['feature1', 'feature2', 'feature3'],
                  'key2' => ['feature2', 'feature3', 'feature4'])
    end
    
    should "backup and reload the database" do
      tmpfile = Tempfile.new('stupa-test')
      @client.save(tmpfile)
      @client.clear
      assert_equal(@client.size, 0)
      @client.load(tmpfile)
      assert_equal(@client.size, 2)      
    end
  end
end
