# frozen_string_literal: true

module Request
  require 'net/http'
  require 'json'

  class << self
    def get_response(url, project_id, _params = {}, _headers = nil)
      #  _use_desc_order = false
      # params = { :limit => 10, :page => 3, :order => 'desc' }
      # response = Net::HTTP.get_response(URI(url))
      uri = URI(url)
      req = Net::HTTP::Get.new(uri)
      req['project_id'] = project_id
      # TIMEOUT ERROR
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
      format_response(response) # may be get_formatted_response
    end

    def get_all_pages(url)
      # https://docs.ruby-lang.org/en/2.0.0/Net/HTTP.html
      # uri = URI('http://example.com/some_path?query=string')
      # Net::HTTP.start(uri.host, uri.port) do |http|
      #   request = Net::HTTP::Get.new uri
      #   response = http.request request # Net::HTTPResponse object
      # end
    end

    def get_full_object_response
      # Call it if it set in config
    end

    private

    def format_response(response)
      # resque from uncoded:
      # Net::HTTP.get(uri).encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
      body = response.header.content_type == 'application/json' ? JSON.parse(response.body) : response.body
      { status: response.code, body: body } # In config return whole object, default this one
      # Look in the JS implementation
    end
  end
end
