# frozen_string_literal: true

module Hertz
  class Delivery < ActiveRecord::Base
    belongs_to :notification, inverse_of: :deliveries

    validates :notification, presence: true
    validates :courier, presence: true
  end
end
