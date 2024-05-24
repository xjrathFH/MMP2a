class User < ApplicationRecord
  has_many :participations, foreign_key: 'owner_id'
  has_many :bets, foreign_key: 'owner_id'
  has_many :notifications, dependent: :destroy

  after_create :enqueue_balance_job

  def to_s
    "#{first_name} #{last_name}"
  end

  def self.find_or_create_with_omniauth(auth_hash) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    # identify user by provider + uid
    user =
      find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])

    # additional info about the user
    # which info is available depends on provider + scope
    Rails.logger.warn(auth_hash)
    if auth_hash['info']
      user.email = auth_hash['info']['email']
      user.first_name = auth_hash['info']['firstname']
      user.last_name = auth_hash['info']['lastname']
      user.status = auth_hash['info']['status']
      user.department = auth_hash['info']['department']
      user.studies = auth_hash['info']['studies']
    end
    user.access_token = auth_hash['credentials']['token']
    user.token_expires_at =
      DateTime.strptime(auth_hash['credentials']['expires_at'].to_s, '%s')
    user.save!
    user
  end

  private

  def enqueue_balance_job
    InitBalanceJob.perform_later(id)
  end
end
