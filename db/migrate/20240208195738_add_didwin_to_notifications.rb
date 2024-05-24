class AddDidwinToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :didwin, :boolean
  end
end
