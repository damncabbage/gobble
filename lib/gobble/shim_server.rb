require 'gobble/shim_server/errors'

module Gobble
  class ShimServer

    attr_accessor :queues

    def initialize
      @queues = {}
    end

    def call(env)
      req = Rack::Request.new(env)
      case req.path
      when '/gobble-server/responses'
        dispatch_response_queue(req.request_method, req.host, req.body.read) || not_found
      when '/gobble-server/requests'
        not_implemented # TODO
      else
        dequeue(req.host) or raise QueueEmpty
      end
    rescue *[Error, JSON::ParserError] => e
      bad_request e.message
    end

    def dispatch_response_queue(method, host, body)
      case method
      when 'HEAD'
        response_with_queue queues[host]
      when 'GET'
        response_with_queue queues[host]
      when 'POST'
        enqueue host, JSON.parse(body)
        response_with_queue queues[host]
      when 'DELETE'
        self.queues[req.host] = []
        response_with_queue queues[host]
      end
    end

    def enqueue(host, response)
      # [status, {"header" => "hash"}, [response]]
      # HACK: Clumsy checking.
      if response.is_a?(Array) && response.count == 3 && response[0].is_a?(Fixnum) && response[1].is_a?(Hash)
        wrapped_body = (response[2].respond_to?(:each) ? response[2] : [response[2]])
        self.queues[host] ||= []
        self.queues[host] << [response[0], response[1], wrapped_body]
      else
        raise InvalidQueueItem
      end
    end

    def dequeue(host)
      queues[host] && queues[host].shift
    end

    protected

      def response_with_queue(queue)
        body = (queue || []).to_json
        [200, {"Content-Type" => "application/json"}, [body]]
      end

      def not_found
        [404, {"Content-Type" => "text/html"}, ["Not found."]]
      end

      def not_implemented
        [500, {"Content-Type" => "text/html"}, ["TODO: Not implemented."]]
      end

      def bad_request(message)
        [400, {"Content-Type" => "text/html"}, [message]]
      end
  end
end
