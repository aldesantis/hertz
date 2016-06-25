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

    def build_courier(courier)
      "Hertz::Courier::#{courier.to_s.camelcase}".constantize
    end

    def validate_couriers(*couriers)
      couriers.flatten.each do |courier|
        validate_courier courier
      end
    end

    def validate_courier(courier)
      build_courier courier
    rescue NameError
      raise(InvalidCourierError, courier)
    end
  end

  class InvalidCourierError < StandardError
    attr_reader :courier

    def initialize(courier)
      @courier = courier
      super "#{courier} is not a valid Hertz courier"
    end
  end
end
