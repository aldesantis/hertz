class RenameNotificationDeliveriesToDeliveries < ActiveRecord::Migration
  def change
    rename_table :hertz_notification_deliveries, :hertz_deliveries
  end
end
