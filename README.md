# Blockfrostruby

Ruby SDK to work with Blockfrost (Cardano Blockchain API)
Blockfrost is a hosted API as a service serving the data from the Cardano blockchain.
This gem is Ruby SDK for Blockfrost.io to enable developers
to use full power of this API without having to create basic functions for it.
The OpenAPI documentation is hosted at https://github.com/blockfrost/openapi.\
This gem is licensed under ASL 2.0.

More information about using this API can be found on https://docs.blockfrost.io/
## Installation

For now it's not hosted on a RubyGems,
so you can install this SDK only from this repo.

To do this, download this repo to your machine, go to the directory:

    $ cd path-to-dir-with-this-repo

And then run next commands:

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

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/blockfrostruby.
