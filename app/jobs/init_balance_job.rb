class InitBalanceJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    # Calculate and update balance based on studies and current date
    init_balance(user)
  end

  private

  def init_balance(user) # rubocop:disable Metrics/MethodLength
    current_date = Time.now

    if user.status != 'STUD'
      user.update(balance: 180)
    else
      studies_year = user.studies.match(/\d{4}/).to_s.to_i
      years_studying =
        current_date.year >= studies_year ? current_date.year - studies_year : 1

      # Calculate balance for each September and February
      calculated_balance = years_studying * 2 * 30 - 30
      total_balance = calculated_balance

      user.update(balance: total_balance)
    end
  end
end
