# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative 'blockfrostruby/configuration'

module Request
  # REQUIRE CONFIG WITH METHOD WHICH CAN USE CONFIG
  # SHOULD HAVE MANAGER METHOD
  include Configuration 

  class << self
    def get_response(url, project_id, params = {}, _headers = nil)
      # response = Net::HTTP.get_response(URI(url))
      
      # url = add_params_to_url(url, params)
      # uri = URI(url)
      # req = Net::HTTP::Get.new(uri)
      # req['project_id'] = project_id
      # # TIMEOUT ERROR
      # response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
      # format_response(response) # may be get_formatted_response
    end

    def get_all_pages(url)
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
      # resque from uncoded:
      # Net::HTTP.get(uri).encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
      body = response.header.content_type == 'application/json' ? JSON.parse(response.body) : response.body
      { status: response.code, body: body } # In config return whole object, default this one
      # Look in the JS implementation
    end

    def permitted(params)
      params.transform_keys(&:to_sym).slice(:order, :page, :count)
    end

    def add_params_to_url(url, params)
      # to work with previous versions of ruby
      # https://stackoverflow.com/questions/800122/best-way-to-convert-strings-to-symbols-in-hash
      permitted_params = permitted(params)
      return url if permitted_params.empty?

      request_params = permitted_params.map { |k, v| "#{k}=#{v}" }.join('&')
      "#{url}?#{request_params}"
    end

    def define_params(params, config)
      default_config = {
        return_whole_object_in_request: false,
        parallel_requests: 5,
        use_desc_order_as_default: false,
        default_count_per_page: 100
      }
      # params = { order: 'desc', count: 2 }
      permitted_params = permitted(params)
      result = permitted_params
      puts "result: #{result}"
      result[:order] = result[:order]&.downcase

      order_param_in_default_config = default_config[:use_desc_order_as_default] == false ? 'asc' : 'desc'
      order_param_in_object_config = config[:use_desc_order_as_default] == false ? 'asc' : 'desc'
      
      puts "default config: #{order_param_in_default_config}"
      puts "object config: #{order_param_in_object_config}"
      result[:order] = order_param_in_object_config if order_param_in_object_config != order_param_in_default_config && order_param_in_object_config 
      result[:order] = permitted_params[:order] if permitted_params[:order] != result[:order]
      puts "result[:order] = #{result[:order]}"
      #result.delete(:order) if result[:order] == nil
      result.delete(:order) if result[:order]&.downcase == order_param_in_default_config || result[:order] == nil
      result
    end

    def define_params_2(params, config)
      permitted_params = params.transform_keys(&:to_sym).slice(:order, :page, :count)
      result = permitted_params
      puts result[:order]
      result[:order] = define_order(result[:order], config)
      result.delete(:order) if result[:order] == nil
      result
    end

    def define_order(order_param, object_config)
      default_config = {
        return_whole_object_in_request: false,
        parallel_requests: 5,
        use_desc_order_as_default: false,
        default_count_per_page: 100
      }
      #return order_param.downcase if order_param.downcase in ['asc', 'desc']
      #order_param = order_param&.downcase
      order_in_default_config = default_config[:use_desc_order_as_default] == false ? 'asc' : 'desc'
      order_in_object_config = object_config[:use_desc_order_as_default] == false ? 'asc' : 'desc'
      # object = asc, order_param = desc

      #puts order_param
      puts "order_param: #{order_param}, object: #{order_in_object_config}, default: #{order_in_default_config} "
      result = order_in_object_config if order_param == nil 

      result = order_param if order_param != nil
      result = nil if result == order_in_default_config  
      result

    end

    # Checks: 
      # 1. Pass ({}, {use_desc_order_as_default: false}), should return {}
      # 2. Pass ({}, {use_desc_order_as_default: true}), should return {order: desc}
      # 3. Pass ({ order: 'desc' }, {use_desc_order_as_default: true}), should return {order: desc}
      # 4. Pass ({ order: 'asc' }, {use_desc_order_as_default: true}, should return {}
      # 5. Pass ({ order: 'asc' }, {use_desc_order_as_default: false}), should return {}
      # 6. Pass ({ order: 'desc'}, {use_desc_order_as_default: false}, should return {order: desc})

      #count_param_in_config = config[:count]
      #result.delete(:count) if permitted_params[:count].to_i == count_param_in_config.to_i

    def changed_params
    end
    
    

  end
end
