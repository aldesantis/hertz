# frozen_string_literal: true
module Hertz
  class Notification < ActiveRecord::Base
    scope :unread, -> { where 'read_at IS NULL' }

    belongs_to :receiver, inverse_of: :notifications, polymorphic: true

    serialize :meta

    after_create :deliver

    class << self
      protected

      def deliver_by(*couriers)
        @@couriers = couriers.flatten.map(&:to_sym)
      end
    end

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

    private

    def deliver
      Hertz::NotificationDeliverer.deliver(self)
    end
  end
end
