class AddSemesterBalanceJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each { |user| add_balance(user) }
  end

  private

  def add_balance(user)
    current_date = Time.now

    # Check if it's the first of February or the first of September
    if [2, 9].include?(current_date.month) && current_date.day == 1
      current_balance = user.balance || 0
      new_balance = current_balance + 30

      user.update(balance: new_balance)
    end
  end
end
