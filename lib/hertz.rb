# frozen_string_literal: true

require 'hertz/engine'

require 'hertz/notifiable'
require 'hertz/notification_deliverer'

module Hertz
  class << self
    def configure
      yield self
    end

    def common_couriers=(couriers)
      @common_couriers = [couriers].flatten.map(&:to_sym)
    end

    def common_couriers
      @common_couriers ||= []
    end
  end
end
