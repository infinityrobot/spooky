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

    def fetch(resource, options = {})
      resource_type = resource.to_s.match(/^(\w+)/)[0]
      response = fetch_json(resource, options)[resource_type]
      object = "Spooky::#{resource_type.classify}".constantize
      if response
        array = response.map { |o| object.send(:new, o) }
        options[:id] ? array.reduce : array
      end
    end

    def fetch_with_associations(resource, options = {})
      options[:include] = "author,tags,count.posts"
      fetch(resource, options)
    end

    # Utilities.
    def pages(resource, options = {})
      fetch_json(resource, options)["meta"]["pagination"]["pages"]
    end

    # Client level object collection methods.
    [:posts, :tags, :users].each do |object|
      define_method(object) do |options = {}|
        fetch_with_associations(object, options)
      end

      define_method("#{object.to_s.singularize}_pages") do |options = {}|
        pages(object, options)
      end

      define_method("find_#{object.to_s.singularize}_by_id") do |id|
        fetch_with_associations(object, id: id)
      end

      define_method("find_#{object.to_s.singularize}_by_slug") do |slug|
        fetch_with_associations("#{object}/slug", id: slug)
      end
    end

    private

    def check_credentials!
      creds_check = @subdomain && @client_id && @client_secret
      raise ArgumentError, "Credentials must be initialized" unless creds_check
    end
  end
end
