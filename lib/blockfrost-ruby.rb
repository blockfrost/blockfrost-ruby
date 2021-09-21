# frozen_string_literal: true

# gem build blockfrost-ruby
# gem install ./blockfrost-ruby-0.1.0.gem
# require 'blockfrost-ruby'
# blockfrost = Blockfrostruby::CardanoMainNet.new()

require 'dotenv/load'

require_relative 'blockfrostruby/version'
require_relative 'blockfrostruby/constants'
require_relative 'blockfrostruby/configuration'

require_relative 'blockfrostruby/endpoints/cardano/health_endpoints'
require_relative 'blockfrostruby/endpoints/cardano/metrics_endpoints'
require_relative 'blockfrostruby/endpoints/cardano/accounts_endpoints'
require_relative 'blockfrostruby/endpoints/cardano/addresses_endpoints'
require_relative 'blockfrostruby/endpoints/cardano/assets_endpoints'
require_relative 'blockfrostruby/endpoints/cardano/blocks_endpoints'
require_relative 'blockfrostruby/endpoints/cardano/epochs_endpoints'
require_relative 'blockfrostruby/endpoints/cardano/ledger_endpoints'
require_relative 'blockfrostruby/endpoints/cardano/metadata_endpoints'
require_relative 'blockfrostruby/endpoints/cardano/network_endpoints'
require_relative 'blockfrostruby/endpoints/cardano/pools_endpoints'
require_relative 'blockfrostruby/endpoints/cardano/transactions_endpoints'
require_relative 'blockfrostruby/endpoints/cardano/nutlink_endpoints'
require_relative 'blockfrostruby/endpoints/ipfs/ipfs_endpoints'
require_relative 'blockfrostruby/endpoints/custom_endpoints'

module Blockfrostruby
  class Net
    include Configuration
    include CustomEndpoints

    attr_reader :config, :project_id, :url

    def initialize(project_id, config = {})
      @project_id = project_id
      @url = nil
      @config = Configuration.define_config(config)
    end
  end

  class CardanoMainNet < Net
    include HealthEndpoints
    include MetricsEndpoints
    include AccountsEndpoints
    include AddressesEndpoints
    include AssetsEndpoints
    include BlocksEndpoints
    include EpochsEndpoints
    include LedgerEndpoints
    include MetadataEndpoints
    include NetworkEndpoints
    include PoolsEndpoints
    include TransactionsEndpoints
    include NutlinkEndpoints

    # Create an instanse of CardanoMainNet object.
    # Using of SDK is a calling methods on such object.
    #
    # @param project_id [String] the project_id from API
    # @param config [Hash] a config with params: use_asc_order_as_default, default_count_per_page, parallel_requests, sleep_between_retries_ms
    # @return [Object] with attr_reader :config, :project_id, :url
    def initialize(project_id, config = {})
      super
      @url = CARDANO_MAINNET_URL
    end
  end

  class CardanoTestNet < CardanoMainNet
    # Create an instanse of CardanoTestNet object.
    # Using of SDK is a calling methods on such object.
    #
    # @param project_id [String] the project_id from API
    # @param config [Hash] a config with params: use_asc_order_as_default, default_count_per_page, parallel_requests, sleep_between_retries_ms
    # @return [Object] with attr_reader :config, :project_id, :url
    def initialize(project_id, config = {})
      super
      @url = CARDANO_TESTNET_URL
    end
  end

  class IPFS < Net
    include IPFSEndpoints

    # Create an instanse of IPFS object.
    # Using of SDK is a calling methods on such object.
    #
    # @param project_id [String] the project_id from API
    # @param config [Hash] a config with params: use_asc_order_as_default, default_count_per_page, parallel_requests, sleep_between_retries_ms
    # @return [Object] with attr_reader :config, :project_id, :url
    def initialize(project_id, config = {})
      super
      @url = IPFS_URL
    end
  end

  class Error < StandardError; end
end
