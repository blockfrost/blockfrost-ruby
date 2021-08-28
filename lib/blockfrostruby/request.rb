# frozen_string_literal: true

require 'net/http'
require 'json'

require_relative './version'

module Request
  include Blockfrostruby

  class << self
    def get_response(url, project_id, params = {})
      uri = URI(add_params_to_url(url, params))
      req = Net::HTTP::Get.new(uri)
      req['project_id'] = project_id
      req['User-Agent'] = sdk_identificator
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
      format_response(response)
    end

    # TODO: Refactor post methods

    def post_request_cbor(url, project_id, body, params = {})
      uri = URI(add_params_to_url(url, params))
      req = Net::HTTP::Post.new(uri)
      req['project_id'] = project_id
      req['Content-Type'] = 'application/cbor'
      req['User-Agent'] = sdk_identificator
      req.body = body
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
      format_response(response)
    end

    def post_file(url, project_id, filepath)
      # Or directory
      uri = URI(url)
      file = [['upload', File.open(filepath)]]
      req = Net::HTTP::Post.new(uri)
      req['project_id'] = project_id
      req['User-Agent'] = sdk_identificator
      req.set_form file, 'multipart/form-data'
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
      format_response(response)
    end

    def post_request_raw(url, project_id)
      uri = URI(url)
      req = Net::HTTP::Post.new(uri)
      req['project_id'] = project_id
      req['Content-Type'] = 'text/plain'
      req['User-Agent'] = sdk_identificator
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
    end

    private

    def format_response(response)
      content_type = response.header.content_type
      able_to_parse = ['application/json', 'application/octet-stream'].include?(content_type)
      body = able_to_parse ? JSON.parse(response.body) : response.body
      { status: response.code, body: body }
    end

    def add_params_to_url(url, params)
      return url if params.empty?

      request_params = params.map { |k, v| "#{k}=#{v}" }.join('&')
      "#{url}?#{request_params}"
    end

    def sdk_identificator
      "Blockfrost-Ruby, version: #{Blockfrostruby::VERSION} "
    end
  end
end
