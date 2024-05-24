class HomeController < ApplicationController
  def index
    @bets_with_most_participants =
      Bet
        .left_joins(:participations)
        .group(:id)
        .order('bet.id DESC')
        .order('COUNT(participations.id) DESC')
        .limit(3)
  end
end
