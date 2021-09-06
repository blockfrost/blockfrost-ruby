# frozen_string_literal: true

require 'net/http'
require 'json'

require_relative './version'
require_relative './constants'

module Request
  include Blockfrostruby

  class << self
    def get_response(url, project_id, params = {})
      params[:from_page] ? get_pages_multi(url, project_id, params) : get_response_from_url(url, project_id, params)
    end

    def post_request_raw(url, project_id)
      uri = URI(url)
      request = create_post_request(uri, project_id)
      request['Content-Type'] = 'text/plain'
      response = send_request(uri, request)
      format_response(response)
    end

    def post_request_cbor(url, project_id, body)
      uri = URI(url)
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
      sliced_params = params.slice(:order, :page, :count, :from, :to).compact
      return url if sliced_params.empty?

      request_params = sliced_params.map { |k, v| "#{k}=#{v}" }.join('&')
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

    def get_response_from_url(url, project_id, params = {})
      uri = URI(add_params_to_url(url, params))
      request = create_get_request(uri, project_id)
      response = send_request(uri, request)
      format_response(response)
    end

    def get_pages(url, project_id, params = {})
      responses = []
      page_number = params[:from_page]

      loop do
        break if params[:to_page] && (page_number > params[:to_page])

        response = get_response_from_page(url, project_id, page_number, params)

        break if response.nil?

        responses << response
        page_number += 1
      end
      format_pages_results(responses)
    end

    def get_pages_multi(url, project_id, params = {})
      parallel_requests = params[:parallel_requests]
      sleep_retries = params[:sleep_between_retries_ms]
      responses = []
      numbers = []
      page_number = params[:from_page]
      threads = []
      stops = false
      loop do
        parallel_requests.times do |i|
          threads << Thread.new(page_number) do
            local_page_number = page_number + i

            stops = true if params[:to_page] && (local_page_number > params[:to_page])
            next if params[:to_page] && (local_page_number > params[:to_page])

            response = get_response_from_page(url, project_id, local_page_number, params)

            stops = true if response.nil?
            next if response.nil?
            
            if response[:status].to_i == 402
              raise ScriptError, "You've been reached your daily limit" 
              stops = true
              next
            end

            if response[:status].to_i == 418
              raise ScriptError, "You've been temporary banned for too many requests"
              stops = true
              next
            end
            
            if response[:status].to_i == 429
              for i in (1..MAX_RETRIES_IN_PARALLEL_REQUESTS)
                sleep sleep_retries / 1000.0
                response = get_response_from_page(url, project_id, local_page_number, params)
                break if response[:status].to_i == 200
              end
            end
            if response[:status].to_i == 429
              raise ScriptError, "Please, try again later" 
              stops = true
              next
            end
            responses << { page_number: local_page_number, response: response }
            numbers << local_page_number
            page_number += 1
          end
        end

        threads.each(&:join)
        break if params[:to_page] && (page_number > params[:to_page])
        break if stops == true
        numbers.sort!
        if numbers != numbers.uniq
          raise RuntimeError, 
            'The response includes duplicated results, reduce the number of parallel_requests and try again'
          break
        end
      end
      responses.sort! { |el1, el2| el1[:page_number] <=> el2[:page_number] }.map! { |el| el[:response] }
      format_pages_results(responses)
    end

    def get_response_from_page(url, project_id, page_number, params = {})
      params_to_pass = params.slice(:order, :count).merge(page: page_number) # Why slice here?
      response = get_response_from_url(url, project_id, params_to_pass)
      return if response[:body].empty?

      response
    end

    def format_pages_results(responses)
      result = { status: nil, body: [] }
      result[:body] = responses.map { |r| r[:body] }.flatten
      puts responses.flatten.map { |r| r[:status] }
      result[:status] = responses.flatten.map { |r| r[:status] }[-1]
      result[:status] = result[:status].to_i if result[:status]
      result
    end
  end
end
