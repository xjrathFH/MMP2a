class CreateBets < ActiveRecord::Migration[7.1]
  def change
    create_table :bets do |t|
      t.integer :owner_id, null: false
      t.string :title, null: false
      t.string :description
      t.float :minimum_fee, null: false
      t.boolean :public, null: false
      t.boolean :outcome
      t.string :winning_condition, null: false

      t.timestamps
    end
  end
end
