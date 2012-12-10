module Gobble
  class ShimServer
    class Error < StandardError; end
    class InvalidQueueItem < Error; end
    class QueueEmpty < Error; end
  end
end
