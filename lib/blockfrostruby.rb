# frozen_string_literal: true

# gem build blockfrostruby
# gem install ./blockfrostruby-0.1.0.gem

require_relative 'blockfrostruby/version'
require 'net/http'
require 'json'

module Blockfrostruby
  # Net::HTTP.get(uri).encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
  # https://dog.ceo/api/breeds/list/all
  # Format = status body

  # Should be separate module with only verbs action
  # puts res.body if res.is_a?(Net::HTTPSuccess)

  class Error < StandardError; end
  # raise error if body status error

  class Request
    def self.get_response(url, _params = {}, _headers = nil)
      # params = { :limit => 10, :page => 3, :order => 'desc' }
      # response = Net::HTTP.get_response(URI(url))
      uri = URI(url)
      req = Net::HTTP::Get.new(URI(url))
      req['project_id'] = "" # || _headers[:project_id]
      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|  http.request(req)}
      
      body = response.header.content_type == 'application/json' ? JSON.parse(response.body) : response.body
      { status: response.code, body: body }
    end

    def self.get_all_pages(url)
      # https://docs.ruby-lang.org/en/2.0.0/Net/HTTP.html
      # uri = URI('http://example.com/some_path?query=string')
      # Net::HTTP.start(uri.host, uri.port) do |http|
      #   request = Net::HTTP::Get.new uri
      #   response = http.request request # Net::HTTPResponse object
      # end
    end
  end

  class CardanoMainNet
    CARDANO_MAINNET_URL = "https://cardano-mainnet.blockfrost.io/api/v0/" # To config
    # Needs to share methods with CardanoTestNet class, the same requests. Use Fabriq with same classes

    def self.get_health
      Request.get_response(CARDANO_MAINNET_URL + "health")
    end
  end
end
