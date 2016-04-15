# This migration comes from hertz (originally 20160415174901)
class CreateHertzNotifications < ActiveRecord::Migration
  def change
    enable_extension 'hstore'

    create_table :hertz_notifications do |t|
      t.string :type, null: false
      t.string :receiver_type, null: false
      t.integer :receiver_id, null: false
      t.hstore :meta, default: {}, null: false
      t.datetime :read_at
      t.datetime :created_at, null: false
    end
  end
end
