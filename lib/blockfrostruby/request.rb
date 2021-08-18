# frozen_string_literal: true

module Request
  require 'net/http'
  require 'json'

  # REQUIRE CONFIG WITH METHOD WHICH CAN USE CONFIG
  # SHOULD HAVE MANAGER METHOD

  class << self
    def get_response(url, project_id, params = {}, _headers = nil)
      # response = Net::HTTP.get_response(URI(url))
      url = add_params_to_url(url, params)
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

    # def get_full_object_response, get_formatted_response

    private

    def format_response(response)
      # resque from uncoded:
      # Net::HTTP.get(uri).encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
      body = response.header.content_type == 'application/json' ? JSON.parse(response.body) : response.body
      { status: response.code, body: body } # In config return whole object, default this one
      # Look in the JS implementation
    end

    def add_params_to_url(url, params)
      # to work with previous versions of ruby
      # https://stackoverflow.com/questions/800122/best-way-to-convert-strings-to-symbols-in-hash
      permitted_params = params.transform_keys(&:to_sym).slice(:order, :page, :count)
      return url if permitted_params.empty?

      request_params = permitted_params.map { |k, v| "#{k}=#{v}" }.join('&')
      "#{url}?#{request_params}"
    end
  end
end
