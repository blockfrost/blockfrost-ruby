# frozen_string_literal: true

require 'net/http'
require 'json'

require_relative './version'

module Request
  include Blockfrostruby

  class << self
    def get_response(url, project_id, params = {})
      params[:from_page] ? get_pages(url, project_id, params) : get_response_from_page(url, project_id, params)
    end

    # To private
    # if the user pass wrong param, string, not int, or less than from_page
    # not from page, but with to page
    # check with using from/to

    def get_response_from_page(url, project_id, params = {})
      uri = URI(add_params_to_url(url, params))
      request = create_get_request(uri, project_id)
      response = send_request(uri, request)
      format_response(response)
    end

    def get_pages(url, project_id, params = {})
      responses = []
      page_number = params[:from_page]
      loop do
        puts "page_number: #{page_number}"
        response = get_answer(url, project_id, params, page_number)

        break if response.nil?
        break if params[:to_page] && (page_number >= params[:to_page])

        responses << response
        page_number += 1
      end
      format_pages_results(responses)
    end

    def get_answer(url, project_id, page_number, params = {})
      params_to_pass = params.slice(:order, :count).merge(page: page_number)
      response = get_response_from_page(url, project_id, params_to_pass)
      return if response[:body].empty?

      response
    end

    def format_pages_results(responses)
      result = { status: nil, body: [] }
      result[:body] = responses.flatten.map { |r| r[:body] }
      result[:status] = responses.flatten.map { |r| r[:status] }[-1]
      result
    end

    # def get_loop_response(params={}, method_or_block)
    #   from = params[:from_page]
    #   to = params[:to_page] || Float::Infinity
    #   counter = params[:from_page]

    #   loop do
    #     yield # in method return if body nil
    #     break if to >= counter
    #   end

    #   take method and call him before finish
    # end

    # def new_method
    #   result = {}
    #   loop do
    #     result << do_something
    #   end
    #   result
    # end

    def post_request_raw(url, project_id)
      uri = URI(url)
      request = create_post_request(uri, project_id)
      request['Content-Type'] = 'text/plain'
      response = send_request(uri, request)
      format_response(response)
    end

    def post_request_cbor(url, project_id, body, params = {})
      uri = URI(add_params_to_url(url, params))
      request = create_post_request(uri, project_id)
      request['Content-Type'] = 'application/cbor'
      request.body = body
      response = send_request(uri, request)
      format_response(response)
    end

    def post_file(url, project_id, filepath)
      uri = URI(url)
      file = [['upload', File.open(filepath)]]
      request = create_post_request(uri, project_id)
      request.set_form file, 'multipart/form-data'
      response = send_request(uri, request)
      format_response(response)
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
      "Blockfrost-Ruby, version: #{Blockfrostruby::VERSION}"
    end

    def create_get_request(uri, project_id)
      req = Net::HTTP::Get.new(uri)
      req['project_id'] = project_id
      req['User-Agent'] = sdk_identificator
      req
    end

    def create_post_request(uri, project_id)
      req = Net::HTTP::Post.new(uri)
      req['project_id'] = project_id
      req['User-Agent'] = sdk_identificator
      req
    end

    def send_request(uri, req)
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
    end
  end
end
