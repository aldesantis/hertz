module Hertz
  module Courier
    class Base
      def self.deliver_notification(notification)
        raise NotImplementedError
      end
    end
  end
end
