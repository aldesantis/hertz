module Hertz
  module Notifiable
    def self.included(base)
      base.class_eval do
        has_many :notifications,
          as: :receiver,
          inverse_of: :receiver,
          dependent: :destroy
      end
    end
  end
end
