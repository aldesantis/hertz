# frozen_string_literal: true
module Hertz
  module Courier
    class Base
      def self.deliver_notification(_notification)
        fail NotImplementedError
      end
    end
  end
end
