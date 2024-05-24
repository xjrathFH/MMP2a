class AddOutcomeToParticipation < ActiveRecord::Migration[7.1]
  def change
    add_column :participations, :outcome, :boolean
  end
end
