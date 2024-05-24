class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bet, null: false, foreign_key: true
      t.string :message, limit: 255, null: false
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
