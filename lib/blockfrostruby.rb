# frozen_string_literal: true

require_relative 'blockfrostruby/version'

module Blockfrostruby
  class Error < StandardError; end

  class Check
    def self.hi
      puts 'Hello world'
    end
  end
end
