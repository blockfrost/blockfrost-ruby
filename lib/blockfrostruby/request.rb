# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative 'configuration'

module Request
  include Configuration

  class << self
    def get_response(url, project_id, params={}) #url_with_params
      url = add_params_to_url(url, params)
      uri = URI(url)
      req = Net::HTTP::Get.new(uri)
      req['project_id'] = project_id
      # TIMEOUT ERROR
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
      format_response(response) # may be get_formatted_response
    end

    def get_all_results(url, project_id)
      # https://docs.ruby-lang.org/en/2.0.0/Net/HTTP.html
      # uri = URI('http://example.com/some_path?query=string')
      # Net::HTTP.start(uri.host, uri.port) do |http|
      #   request = Net::HTTP::Get.new uri
      #   response = http.request request # Net::HTTPResponse object
      # end
    end

    # def get_full_object_response, get_formatted_response

    private

    def format_response(response)
      body = response.header.content_type == 'application/json' ? JSON.parse(response.body) : response.body
      { status: response.code, body: body } # In config return whole object, default this one
    end

    def add_params_to_url(url, defined_params)
      # to work with previous versions of ruby
      # https://stackoverflow.com/questions/800122/best-way-to-convert-strings-to-symbols-in-hash
      return url if defined_params.empty?

      request_params = defined_params.map { |k, v| "#{k}=#{v}" }.join('&')
      "#{url}?#{request_params}"
    end
  end
end
