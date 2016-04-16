module Hertz
  module Notifiable
    def self.included(base)
      base.class_eval <<-RUBY
        has_many :notifications,
          class_name: 'Hertz::Notification',
          as: :receiver,
          inverse_of: :receiver,
          dependent: :destroy

        def notify(notification)
          notifications << notification
        end
      RUBY
    end
  end
end
