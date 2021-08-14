# frozen_string_literal: true 

# gem build blockfrostruby
# gem install ./blockfrostruby-0.1.0.gem

require_relative 'blockfrostruby/version'
require 'net/http'
require 'json'

module Blockfrostruby
  # Net::HTTP.get(uri).encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
  # Check puts on the https://guides.rubygems.org/make-your-own-gem/
  # https://dog.ceo/api/breeds/list/all
  # JSON.parse(Net::HTTP.get(URI("https://dog.ceo/api/breeds/list/all")))
  # Format = status body

  # Should be separate module with only verbs action
  # params = { :limit => 10, :page => 3 }
  # puts res.body if res.is_a?(Net::HTTPSuccess)

  class Error < StandardError; end
  
  class Request
    def self.get_response(url, params={})
      response = Net::HTTP.get_response(URI(url))
      body = response.header.content_type == "application/json" ? JSON.parse(response.body) : response.body
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
end
