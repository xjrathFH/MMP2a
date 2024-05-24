class AddForeignKeyToBets < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :bets, :users, column: :owner_id
  end
end
