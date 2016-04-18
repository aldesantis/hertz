# frozen_string_literal: true
require 'hertz/engine'

require 'hertz/notifiable'
require 'hertz/notification_deliverer'
require 'hertz/courier/base'
require 'hertz/courier/email'
require 'hertz/generators/install_generator' if defined?(Rails::Generators)

module Hertz
  mattr_writer :base_mailer

  def self.configure(&block)
    block.call(self)
  end

  def self.base_mailer
    (@@base_mailer || '::ApplicationMailer').constantize
  end
end
