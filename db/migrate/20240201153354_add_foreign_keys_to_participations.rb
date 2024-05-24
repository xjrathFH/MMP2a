class AddForeignKeysToParticipations < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :participations, :bets
    add_foreign_key :participations, :users, column: :owner_id
  end
end
