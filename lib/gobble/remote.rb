# Rough as guts, will change.
require 'httparty'

module Gobble
  class Remote

    def initialize(uri)
      @uri_base = uri
    end

    def respond_with(status, headers, body)
      HTTParty.post("#{@uri_base}/gobble-server/responses", :body => body, :headers => headers)
    end

    def clear_responses
      HTTParty.delete("#{@uri_base}/gobble-server/responses")
    end

  end
end
