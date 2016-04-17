# frozen_string_literal: true
module Hertz
  class NotificationDeliverer
    class << self
      def deliver(notification)
        notification.class.couriers.each do |courier|
          build_courier(courier).deliver_notification(notification)
        end
      end

      private

      def build_courier(courier)
        "Hertz::Courier::#{courier.to_s.camelcase}".constantize
      end
    end
  end
end
