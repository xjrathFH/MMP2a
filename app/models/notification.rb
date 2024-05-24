# frozen_string_literal: true

# Notification
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :bet
end
