# frozen_string_literal: true

# gem build blockfrostruby
# gem install ./blockfrostruby-0.1.0.gem
# require 'blockfrostruby'
# Blockfrostruby::CardanoMainNet

require_relative 'blockfrostruby/version'
require_relative 'blockfrostruby/constants'

module Request
  require 'net/http'
  require 'json'

  class << self
    def get_response(url, project_id, _params = {}, _headers = nil)
      # params = { :limit => 10, :page => 3, :order => 'desc' }
      # response = Net::HTTP.get_response(URI(url))
      uri = URI(url)
      req = Net::HTTP::Get.new(uri)
      req['project_id'] = project_id
      # TIMEOUT ERROR
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
      format_response(response)
    end

    def get_all_pages(url)
      # https://docs.ruby-lang.org/en/2.0.0/Net/HTTP.html
      # uri = URI('http://example.com/some_path?query=string')
      # Net::HTTP.start(uri.host, uri.port) do |http|
      #   request = Net::HTTP::Get.new uri
      #   response = http.request request # Net::HTTPResponse object
      # end
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

module HealthEndpoints
  extend Request

  def get_root
    Request.get_response("#{@url}/", @project_id)
  end

  def get_health
    Request.get_response("#{@url}/health", @project_id)
  end

  def get_health_clock
    Request.get_response("#{@url}/health/clock", @project_id)
  end
end

module Config
  class Configuration
    attr_accessor :use_full_response_object, :name
    # use asc/desc order
    
    def initialize(use_full_response_object = false, name = 'test')
      @use_full_response_object = use_full_response_object
      @name = name
    end
    
    def [](value)
      self.public_send(value)
    end
  end

  class << self
    def configure
      @configuration = Configuration.new
      yield @configuration if block_given?
      @configuration
    end

    def config
      @configuration || configure
    end
  end
end

module Blockfrostruby
  class CardanoMainNet
    include HealthEndpoints # EndpointsArray
    #include Config

    attr_reader :config

    def initialize(project_id, config=self.class.default_config)
      @project_id = project_id
      @url = CARDANO_MAINNET_URL
      @config = self.class.define_config(config)
    end

    
    class << self
      def get_custom_url
        # used when user wants to add something in the url manually
        # extend Request
      end

      def default_config
        {
          use_asc_order: true
        }
      end

      def define_config(config)
        result = default_config
        config.each do |key, value|
          # rescue if result[key.to_sym].nil?
          result[key.to_sym] = value unless result[key.to_sym].nil?
        end
        result
      end
    end
  end

  class CardanoTestNet < CardanoMainNet
    def initialize(project_id)
      super
      @url = CARDANO_TESTNET_URL
    end
  end

  class Error < StandardError; end
  # raise error if body status error
end
