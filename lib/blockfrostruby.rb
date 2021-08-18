# frozen_string_literal: true

# gem build blockfrostruby
# gem install ./blockfrostruby-0.1.0.gem
# require 'blockfrostruby'
# Blockfrostruby::CardanoMainNet

require_relative 'blockfrostruby/version'
require_relative 'blockfrostruby/constants'
require_relative 'blockfrostruby/configuration'
# Change to the https://stackoverflow.com/questions/735073/best-way-to-require-all-files-from-a-directory-in-ruby
require_relative 'blockfrostruby/endpoints/health_endpoints'
require_relative 'blockfrostruby/endpoints/metrics_endpoints'

module Blockfrostruby
  class CardanoMainNet
    include Configuration
    include HealthEndpoints # EndpointsArray
    include MetricsEndpoints

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

    def self.help_info
      # provide a link to doc
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
