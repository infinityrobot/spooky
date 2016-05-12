require "httparty"
require "active_support/core_ext/string"

module Spooky
  class Client
    attr_accessor :subdomain, :client_id, :client_secret, :endpoint

    def initialize(attrs = {})
      @subdomain = ENV["GHOST_SUBDOMAIN"] || attrs[:subdomain]
      @client_id = ENV["GHOST_CLIENT_ID"] || attrs[:client_id]
      @client_secret = ENV["GHOST_CLIENT_SECRET"] || attrs[:client_secret]
      @endpoint = "https://#{subdomain}.ghost.io/ghost/api/v0.1/"

      check_credentials!
    end

    # Fetch methods.
    def fetch_json(resource, options = {})
      url = @endpoint.dup
      url << "#{resource}/"
      if options
        option_params = options.map { |k, v| "&#{k}=#{v}" }.join
        url << (options[:id] ? "#{options[:id]}?" : "?#{option_params}")
      end
      url << "&client_id=#{@client_id}&client_secret=#{@client_secret}"
      HTTParty.get(url).parsed_response
    end

    # Utilities.
    def pages(resource, options = {})
      fetch_json(resource, options)["meta"]["pagination"]["pages"]
    end

    private

    def check_credentials!
      creds_check = @subdomain && @client_id && @client_secret
      raise ArgumentError, "Credentials must be initialized" unless creds_check
    end
  end
end
