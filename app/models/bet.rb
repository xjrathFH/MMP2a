class Bet < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :participations

  validates :title, presence: true
  validates :winning_condition, presence: true
  validates :minimum_fee, presence: true
end
