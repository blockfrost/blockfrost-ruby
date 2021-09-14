# frozen_string_literal: true

require 'blockfrostruby'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec::Expectations.configuration.on_potential_false_positives = :nothing

def stub_cardano_success_request(endpoint, response_body, project_id)
  stub_request(:get, "#{CARDANO_MAINNET_URL}#{endpoint}")
    .with(headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host' => 'cardano-mainnet.blockfrost.io',
            'Project-Id' => project_id.to_s,
            'User-Agent' => "Blockfrost-Ruby, version: #{Blockfrostruby::VERSION}"
          }).to_return(status: 200, body: response_body, headers: {
                         'Content-Type' => 'application/json; charset=utf-8'
                       })
end
