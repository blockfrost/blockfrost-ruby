# frozen_string_literal: true

# gem build blockfrostruby
# gem install ./blockfrostruby-0.1.0.gem
# require 'blockfrostruby'
# Blockfrostruby::CardanoMainNet

require_relative 'blockfrostruby/version'
require_relative 'blockfrostruby/constants'
require_relative 'blockfrostruby/configuration'
require_relative 'blockfrostruby/endpoints/health_endpoints'

module Blockfrostruby
  class CardanoMainNet
    include HealthEndpoints # EndpointsArray
    include Configuration

    attr_reader :config, :project_id

    def initialize(project_id, config = {})
      @project_id = project_id
      @url = CARDANO_MAINNET_URL
      @config = Configuration.define_config(config)
    end

    def self.get_custom_url
      # used when user wants to add something in the url manually
      # extend Request
    end
  end

  class CardanoTestNet < CardanoMainNet
    def initialize(project_id, config = {})
      super
      @url = CARDANO_TESTNET_URL
    end
  end

  class Error < StandardError; end
  # raise error if body status error
end
