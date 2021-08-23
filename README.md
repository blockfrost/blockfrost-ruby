# Blockfrostruby

Ruby SDK to work with Blockfrost (Cardano Blockchain API)
Blockfrost is a hosted API as a service serving the data from the Cardano blockchain.
This gem is Ruby SDK for Blockfrost.io to enable developers
to use full power of this API without having to create basic functions for it.
The OpenAPI documentation is hosted at https://github.com/blockfrost/openapi.\
This gem is licensed under ASL 2.0.

More information about using this API can be found on https://docs.blockfrost.io/
## Installation

For now, it's not hosted on a RubyGems,
so you can install this SDK only from this repo.

To do this, download this repo to your machine, then go to the directory:

    $ cd path-to-dir-with-this-repo

And run next commands:

    $ git add .
    $ gem build blockfrostruby
    $ gem install ./blockfrostruby-0.1.0.gem

That's it! You may use the gem in your projects.

<!--
Add this line to your application's Gemfile:

```ruby
gem 'blockfrostruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install blockfrostruby -->

## Usage

To use this SDK, you first need login into blockfrost.io and create your project to retrieve your API token.

And here are examples of how to use this SDK.

```ruby

require 'blockfrostruby'

blockfrost = Blockfrostruby::CardanoMainNet.new('your-API-key')
blockfrost.get_health
blockfrost.get_transaction('f6780212...36f0c20b6')

# The result of request is a hash object with keys [:status, :body]. Examples:
# {:status=>"200", :body=>{"is_healthy"=>true}}
# {:status=>"404", :body=>{"status_code"=>404, "error"=>"Not Found", "message"=>"The requested component has not been found."}}

# Requests which returns a list of result can be called with params.
# Allowed params: :count, :page, :order, :from, :to.
blockfrost.get_asset_history('81791e9e..1303035', { count: 50, page: 3, order: 'desc' })


# You may define what value should be used by default when you initialize the object.
# Default values are: { use_asc_order_as_default: true, default_count_per_page: 100 }
config = { use_asc_order_as_default: false, default_count_per_page: 10 }
blockfrost_configured = Blockfrostruby::CardanoMainNet.new('your-API-key', config)
blockfrost_configured.get_block_latest_transactions # will add order=asc&count=10 to request

# But you're still able to set params for specific action:
blockfrost_configured.get_block_latest_transactions({ count: 20 }) # will add order=asc&count=20 to request

# ==================
# ==================

# On the other words: 

# 1. Install the gem and require it

require 'blockfrostruby'

# 2. Initialize the object with the network:

blockfrost_mainnet = Blockfrostruby::CardanoMainNet.new('your-API-key')
blockfrost_testnet = Blockfrostruby::CardanoTestNet.new('your-API-key')
blockfrost_ipfs = Blockfrostruby::IPFS.new('your-API-key')

# 3. When you initialize, you may configure what params this object will use as default:

config = { default_count_per_page: 10 }
blockfrost_configured = Blockfrostruby::CardanoMainNet.new('your-API-key', config)

# 4. And you may pass params explicitly for every request if that request accept params

blockfrost_configured.get_block_latest_transactions({ count: 20 })

# That's it! Enjoy

```
All endpoints can be found here: https://docs.blockfrost.io/

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/blockfrost/blockfrostruby.
