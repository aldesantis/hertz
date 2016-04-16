module Hertz
  class Notification < ActiveRecord::Base
    scope :unread, -> { where 'read_at IS NULL' }

    belongs_to :receiver, inverse_of: :notifications, polymorphic: true

    serialize :meta

    after_create :deliver

    def couriers
      @@couriers ||= []
    end

    def read?
      read_at.present?
    end

    def unread?
      read_at.nil?
    end

    def mark_as_read
      update read_at: Time.zone.now
    end

    def mark_as_unread
      update read_at: nil
    end

    protected

    def self.deliver_by(*couriers)
      @@couriers = couriers.flatten.map(&:to_sym)
    end

    private

    def deliver
      Hertz::NotificationDeliverer.deliver(self)
    end
  end
end
