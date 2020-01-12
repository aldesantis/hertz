# frozen_string_literal: true

class RenameNotificationDeliveriesToDeliveries < ActiveRecord::Migration[5.0]
  def change
    rename_table :hertz_notification_deliveries, :hertz_deliveries
  end
end
