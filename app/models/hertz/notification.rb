# frozen_string_literal: true

module Hertz
  class Notification < ActiveRecord::Base
    @couriers = []

    scope :read, -> { where 'read_at IS NOT NULL' }
    scope :unread, -> { where 'read_at IS NULL' }

    belongs_to :receiver, inverse_of: :notifications, polymorphic: true
    has_many :deliveries, inverse_of: :notification

    after_commit :deliver, on: %i[create update]

    class << self
      def couriers
        @couriers ||= []
      end

      protected

      def deliver_by(*couriers)
        @couriers = couriers.flatten.map(&:to_sym)
      end
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

    def delivered_with?(courier)
      deliveries.where(courier: courier).exists?
    end

    def mark_delivered_with(courier)
      deliveries.create(courier: courier)
    end

    private

    def deliver
      Hertz::NotificationDeliverer.deliver(self)
    end
  end
end
