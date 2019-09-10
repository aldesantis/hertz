# This migration comes from hertz (originally 20160627084018)
class CreateHertzNotificationDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :hertz_notification_deliveries do |t|
      t.integer :notification_id, null: false
      t.index :notification_id
      t.foreign_key :hertz_notifications, column: :notification_id, on_delete: :cascade
      t.string :courier, null: false
      t.datetime :created_at, null: false
      t.index [:notification_id, :courier], unique: true, name: 'index_hertz_notification_deliveries_on_notification_and_courier'
    end
  end
end
