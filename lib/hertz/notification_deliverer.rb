module Hertz
  class NotificationDeliverer
    def self.deliver(notification)
      notification.couriers.each do |courier|
        build_courier(courier).deliver_notification(notification)
      end
    end

    private

    def self.build_courier(courier)
      "Hertz::Courier::#{courier.to_s.camelcase}".constantize
    end
  end
end
