class Participation < ApplicationRecord
  belongs_to :bet
  belongs_to :owner, class_name: 'User'

  validates :outcome, presence: true, unless: -> { outcome == false }
end
