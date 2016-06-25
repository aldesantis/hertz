# frozen_string_literal: true
module Hertz
  class NotificationDeliverer
    class << self
      def deliver(notification)
        couriers_for(notification).each do |courier|
          Hertz.build_courier(courier).deliver_notification(notification)
        end
      end

      private

      def couriers_for(notification)
        (notification.class.couriers + Hertz.common_couriers).uniq
      end
    end
  end
end
