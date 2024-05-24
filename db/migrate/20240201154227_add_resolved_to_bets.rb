class AddResolvedToBets < ActiveRecord::Migration[7.1]
  def change
    add_column :bets, :resolved, :boolean
  end
end
