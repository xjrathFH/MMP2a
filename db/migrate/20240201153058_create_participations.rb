class CreateParticipations < ActiveRecord::Migration[7.1]
  def change
    create_table :participations do |t|
      t.integer :bet_id
      t.integer :owner_id
      t.integer :fee, null: false
      t.string :message
      t.boolean :anonymous, null: false

      t.timestamps
    end
  end
end
