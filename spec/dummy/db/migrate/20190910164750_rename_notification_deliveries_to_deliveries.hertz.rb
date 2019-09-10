# This migration comes from hertz (originally 20160628084342)
class RenameNotificationDeliveriesToDeliveries < ActiveRecord::Migration[5.0]
  def change
    rename_table :hertz_notification_deliveries, :hertz_deliveries
  end
end
