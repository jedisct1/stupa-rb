
require 'faraday'
require 'stupa/tsv'
require 'stupa/errors'

module Stupa
  class Client
    SEARCH_DEFAULT_MAX_RESULTS = 20
    DEFAULT_HOST = 'localhost'
    DEFAULT_PORT = 22122
    
    attr_accessor :host, :port, :adapter

    def self.configure
      yield self
      true
    end
    
    def base_url
      "http://#{@host}:#{@port}"
    end
    
    def initialize(params = { })
      @host = params[:host] || DEFAULT_HOST
      @port = params[:port] || DEFAULT_PORT
      @adapter = params[:adapter] || :net_http      
    end
    
    def close; end
      
    def load(file)
      resp = _conn.post '/load' do |req|
        req.body = { file: file }
      end
      _raise_errors(resp)
    end

    def save(file)
      resp = _conn.post '/save' do |req|
        req.body = { file: file }
      end
      _raise_errors(resp)
    end

    def clear
      resp = _conn.post '/clear'
      _raise_errors(resp)
    end
    
    def size
      resp = _conn.get '/size'
      _raise_errors(resp)
      resp.body.to_i
    end
    
    def add(params)
      conn = _conn
      params.each_pair do |_key, features|
        key = _key.to_s
        features = [ features ] unless features.kind_of?(Array)
        features = features.collect { |feature| feature.to_s }
        resp = conn.post '/add' do |req|
          req.body = { id: _key, feature: TSV.join(features) }
        end
        _raise_errors(resp)        
      end
    end
    
    def delete(params)      
      params = [ params ] unless params.respond_to?('each')
      conn = _conn
      params.each do |_key|
        key = _key.to_s
        resp = conn.post '/delete' do |req|
          req.body = { id: key }
        end
        _raise_errors(resp)
      end
    end
    
    def fsearch(params)
      _search('/fsearch', params)
    end
    
    def dsearch(params)
      _search('/dsearch', params)
    end        
    
    private
    
    def _conn(&block)
      Faraday.new(url: base_url) do |builder|
        builder.adapter @adapter
        yield builder if block
      end
    end
    
    def _raise_errors(resp)
      status = resp.status
      raise StupaServerError, "(#{status})" if status >= 500
      raise StupaClientError, "(#{status})" if status >= 400
    end
    
    def _search(url_part, params)
      max = params[:max] || SEARCH_DEFAULT_MAX_RESULTS
      query = params[:query]
      query = [ query ] unless query.kind_of?(Array)
      query = query.collect { |part| part.to_s }
      
      resp = _conn.post url_part do |req|
        req.body = { query: TSV.join(query), max: max }
      end
      _raise_errors(resp)
      TSV.parse_rows_key_and_score(resp.body)      
    end
  end
end
