# frozen_string_literal: true
module Hertz
  module Courier
    module Email
      def self.deliver_notification(notification)
        Hertz::NotificationMailer.notification_email(notification).deliver_later
      end
    end
  end
end
