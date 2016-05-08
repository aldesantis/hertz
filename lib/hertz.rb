# frozen_string_literal: true
require 'hertz/engine'

require 'hertz/notifiable'
require 'hertz/notification_deliverer'

module Hertz
  def self.configure(&block)
    block.call(self)
  end
end
