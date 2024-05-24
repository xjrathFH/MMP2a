# frozen_string_literal: true

# Bets Controller
class BetsController < ApplicationController # rubocop:disable Metrics/ClassLength
  before_action :set_bet, only: %i[show edit update destroy]
  helper_method :resolve_bet

  # GET /bets or /bets.json
  def index
    @bets = Bet.where(public: true)
  end

  def user_bets
    @user = User.find(params[:user_id])
    @user_bets = @user.bets.reverse
  end

  # GET /bets/1 or /bets/1.json
  def show; end

  # GET /bets/new
  def new
    @bet = Bet.new
  end

  # GET /bets/1/edit
  def edit; end

  # POST /bets or /bets.json
  def create # rubocop:disable Metrics/MethodLength
    @bet = Bet.new(bet_params)
    @bet.owner_id = current_user.id
    @bet.resolved = false

    puts bet_params

    respond_to do |format|
      if @bet.save
        format.html do
          redirect_to @bet, notice: 'Bet was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /bets/1 or /bets/1.json
  def update # rubocop:disable Metrics/MethodLength
    respond_to do |format|
      if @bet.update(bet_params)
        format.html do
          redirect_to bet_url(@bet), notice: 'Bet was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @bet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bets/1 or /bets/1.json
  def destroy
    @bet.destroy!

    respond_to do |format|
      format.html do
        redirect_to bets_url, notice: 'Bet was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  # Resolves the bet
  def resolve # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @bet = Bet.find(params[:id])

    return if @bet.resolved

    outcome = params[:bet][:outcome] == '1'

    @bet.update(outcome: outcome, resolved: true)

    @bet.participations.each do |participation|
      user = participation.owner
      participation_fee = participation.fee
      if participation.outcome == outcome
        if user
          updated_balance = user.balance + (participation_fee.to_f * 2)
          user.update(balance: updated_balance)

          # Create a notification for the user
          message =
            "Congrats you have won :) . Credits won: #{participation_fee.to_f * 2} ECT$ !"
          Notification.create(
            user_id: user.id,
            bet_id: @bet.id,
            message: message,
            didwin: true
          )
        else
          puts "User not found with id: #{participation.owner_id}"
        end
      else
        # Create a notification for the user
        message =
          "You have lost the bet :( . Lost credits: #{participation_fee} ECT$ !"
        Notification.create(
          user_id: user.id,
          bet_id: @bet.id,
          message: message,
          didwin: false
        )
      end
    end

    # Redirect after resolving the bet
    redirect_to bet_path(@bet)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bet
    @bet = Bet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bet_params # rubocop:disable Metrics/MethodLength
    params
      .require(:bet)
      .permit(
        :owner_id,
        :title,
        :description,
        :minimum_fee,
        :public,
        :outcome,
        :winning_condition,
        :created_at
      )
  end
end
