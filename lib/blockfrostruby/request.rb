# frozen_string_literal: true

require 'net/http'
require 'json'

module Request
  class << self
    def get_response(url, project_id, params = {})
      url = add_params_to_url(url, params)
      uri = URI(url)
      req = Net::HTTP::Get.new(uri)
      req['project_id'] = project_id
      # TIMEOUT ERROR
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
      format_response(response)
    end

    def post_request_cbor(url, project_id, body, params = {})
      url = add_params_to_url(url, params)
      puts "URL: #{url}"
      uri = URI(url)
      req = Net::HTTP::Post.new(uri)
      req['project_id'] = project_id
      req['Content-Type'] = 'application/cbor'
      req.body = body
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
    end

    private

    def format_response(response)
      body = response.header.content_type == 'application/json' ? JSON.parse(response.body) : response.body
      { status: response.code, body: body }
    end

    def add_params_to_url(url, params)
      return url if params.empty?

      request_params = params.map { |k, v| "#{k}=#{v}" }.join('&')
      "#{url}?#{request_params}"
    end
  end
end
