namespace :balance do
  desc 'Update user balances'
  task update: :environment do
    User.find_each { |user| AddBalanceJob.perform_later(user.id) }
  end
end
