
require 'helper'

class ClientTest < Test::Unit::TestCase
  context "a Stupa client" do
    setup do
      @client = Stupa::Client.new
      @client.clear
    end
    
    should "build base_url" do
      assert_equal(@client.base_url, 'http://localhost:22122')
    end
    
    should "empty the initial database" do
      assert_equal(@client.size, 0)
    end
    
    should "add a single item" do
      @client.add('key1' => 'feat1')
      assert_equal(@client.size, 1)
    end
    
    should "add a couple more items" do
      @client.add('key2' => 'feat2', 'key3' => 'feat3')
      assert_equal(@client.size, 2)      
    end
    
    should "add multiple features to a single item" do
      @client.add('key4' => ['feat4', 'feat5'])
      assert_equal(@client.size, 1)
    end    

    should "add multiple features to a multiple item" do
      @client.add('key5' => ['feat6', 'feat7'], 'key6' => ['feat8', 'feat9'])
      assert_equal(@client.size, 2)
    end

    should "add two items and delete one" do
      @client.add('key5' => ['feat6', 'feat7'], 'key6' => ['feat8', 'feat9'])
      @client.delete('key5')
      assert_equal(@client.size, 1)
    end  

    should "add two items and delete two" do
      @client.add('key5' => ['feat6', 'feat7'], 'key6' => ['feat8', 'feat9'])
      @client.delete(['key5', 'key6'])
      assert_equal(@client.size, 0)
    end  
  end
end
