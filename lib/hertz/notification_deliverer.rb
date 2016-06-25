# frozen_string_literal: true
module Hertz
  class NotificationDeliverer
    class << self
      def deliver(notification)
        notification.class.couriers.each do |courier|
          Hertz.build_courier(courier).deliver_notification(notification)
        end
      end
    end
  end
end
