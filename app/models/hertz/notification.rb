module Hertz
  class Notification < ActiveRecord::Base
    scope :unread, -> { where 'read_at IS NULL' }

    belongs_to :receiver, inverse_of: :notifications, polymorphic: true

    serialize :meta

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
  end
end
