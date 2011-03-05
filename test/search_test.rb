
require 'helper'

class SearchTest < Test::Unit::TestCase
  context "a Stupa client with some data on the server" do
    setup do
      @client = Stupa::Client.new
      @client.clear
      @client.add('key1' => ['feature1', 'feature2', 'feature3'],
                  'key2' => ['feature2', 'feature3', 'feature4'])
    end
    
    should "look for similar documents" do
      result = @client.dsearch(query: 'key1')
      assert_not_nil(result)
      assert_nil(result[:key1])
      assert_not_nil(result['key1'])
      assert_equal(result['key1'], 1.0)
      assert_not_nil(result['key2'])
      assert(result['key2'] < 1.0)
      assert(result['key2'] > 0.0)
    end
    
    should "lookup a nonexistent document" do
      result = @client.dsearch(query: 'nonexistent_key')
      assert_not_nil(result)
      assert(result.empty?)
    end
    
    should "search for a feature" do
      result = @client.fsearch(query: 'feature1')
      assert_not_nil(result['key1'])
      assert(result['key1'] < 1.0)
      assert(result['key1'] > 0.0)
      assert_nil(result['key2'])
    end

    should "search for features" do
      result = @client.fsearch(query: ['feature3', 'feature4'])
      assert_not_nil(result['key1'])
      assert(result['key1'] < 1.0)
      assert(result['key1'] > 0.0)      
      assert_not_nil(result['key2'])
      assert(result['key2'] < 1.0)
      assert(result['key2'] > 0.0)
    end
    
    should "search for nonexistent features" do
      result = @client.fsearch(query: 'nonexistent_feature')
      assert_not_nil(result)
      assert(result.empty?)      
    end
    
    should "check for partial results" do
      result = @client.fsearch(query: 'feature3', max: 1)
      assert(result.size == 1)
    end
  end
end
