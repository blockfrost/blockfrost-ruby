# frozen_string_literal: true

require 'net/http'
require 'json'

require_relative './version'

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
        # with yield
        response = get_response_from_page(url, project_id, page_number, params)

        break if response.nil?
        break if params[:to_page] && (page_number > params[:to_page])

        responses << response
        page_number += 1
      end
      format_pages_results(responses)
    end

    def get_pages_multi(url, project_id, params = {}, thr_count=5)
      responses = []
      page_number = params[:from_page]
      threads = []
      stope = false
      mutex = Mutex.new
      loop do
        puts "page number loop: #{page_number}"
        
        thr_count.times do |i|
          #mutex.synchronize do  
          threads << Thread.new(page_number) do 
            puts "number thread: #{page_number + i}"
          response = get_response_from_page(url, project_id, page_number+i, params)
          
          stope = true if response.nil? 
          stope = true if params[:to_page] && (page_number > params[:to_page])
          next if response.nil?
          next if params[:to_page] && (page_number > params[:to_page])

          responses << response
          page_number += 1
          #number +=1
          #end
          end
        end

          # threads << Thread.new(page_number) do |number|
          # puts "number thread: #{number}"
          # response = get_response_from_page(url, project_id, number, params)
          
          # stope = true if response.nil? 
          # stope = true if params[:to_page] && (page_number > params[:to_page])
          # next if response.nil?
          # next if params[:to_page] && (page_number > params[:to_page])

          # responses << response
          # page_number += 1
        # end
        threads.each { |thr| thr.join }
        break if params[:to_page] && (page_number > params[:to_page])
        break if stope == true
      end
      
      #format_pages_results(responses)
    end


    # def get_exp(url, project_id, params = {})
    # responses = []
    # page_number = params[:from_page]
    # threads = []
    # loop do |page_number|
    #   puts "page number loop: #{page_number}"
    #   yield page_number

      
      
    #   break if params[:to_page] && (page_number > params[:to_page])
    # end
    # # threads.each { |thr| thr.join }
    # format_pages_results(responses)
    # end

    # def call(url, project_id, params = {})
    # threads << Thread.new(page_number) do |number|
    #   puts "number thread: #{number}"
    #   response = get_response_from_page(url, project_id, number, params)

    #   break if response.nil?
    #   break if params[:to_page] && (page_number > params[:to_page])

    #   responses << response
    #   page_number += 1
    # end
    # end





    def get_response_from_page(url, project_id, page_number, params = {})
      params_to_pass = params.slice(:order, :count).merge(page: page_number) # Why slice here?
      response = get_response_from_url(url, project_id, params_to_pass)
      return if response[:body].empty?

      response
    end

    def format_pages_results(responses)
      result = { status: nil, body: [] }
      result[:body] = responses.map { |r| r[:body] }.flatten
      result[:status] = responses.flatten.map { |r| r[:status] }[-1]
      result
    end
  end
end
