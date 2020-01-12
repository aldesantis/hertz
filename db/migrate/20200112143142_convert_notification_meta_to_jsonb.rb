# frozen_string_literal: true

class ConvertNotificationMetaToJsonb < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      dir.up do
        change_column_null :hertz_notifications, :meta, true
        change_column_default :hertz_notifications, :meta, nil
        change_column :hertz_notifications, :meta, 'jsonb USING meta::jsonb'
        change_column_default :hertz_notifications, :meta, {}
      end
    end
  end
end
