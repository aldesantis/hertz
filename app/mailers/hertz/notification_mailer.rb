# frozen_string_literal: true
module Hertz
  class NotificationMailer < Hertz.base_mailer
    def notification_email(notification)
      @notification = notification

      mail(
        to: notification.receiver.hertz_email,
        subject: notification.email_subject,
        template_name: view_for(notification)
      )
    end

    private

    def view_for(notification)
      if notification.respond_to?(:email_template)
        notification.email_template
      else
        notification.class.to_s.underscore
      end
    end
  end
end
