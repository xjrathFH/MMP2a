# frozen_string_literal: true

# Participation Controller
class ParticipationsController < ApplicationController
  before_action :set_participation, only: %i[show edit update destroy]

  # GET /participations or /participations.json
  def index
    @participations = Participation.all
    @bets = Bet.all
  end

  # GET /participations/1 or /participations/1.json
  def show; end

  # GET /participations/new
  def new
    @bet = Bet.find_by(id: params[:bet_id])

    unless @bet
      flash[:error] = 'Invalid Bet ID. Please select a valid bet.'
      redirect_to root_path # Adjust the redirection as needed
      return
    end

    @participation = Participation.new
    @participation.bet_id = @bet.id

    @highest_p = @bet.participations.order(fee: :desc).limit(3)

    @owner_name = User.find_by(id: @bet.owner_id).username
  end

  # GET /participations/1/edit
  def edit; end

  # POST /participations or /participations.json
  def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    @participation = Participation.new(participation_params)
    @participation.owner_id = current_user.id
    @participation.anonymous = params[:participation][:anonymous] == '1'
    @participation.outcome = params[:participation][:outcome] == '1'

    Rails.logger.debug "Participation Information: #{@participation.inspect}"

    puts '111222333'
    puts @participation.inspect

    respond_to do |format|
      if user_has_enough_balance?(
           @participation.owner_id,
           @participation.fee
         ) && @participation.save
        deduct_balance(@participation.owner_id, @participation.fee) # Deduct the fee from the user's balance
        format.html do
          redirect_to participation_url(@participation),
                      notice: 'Participation was successfully created.'
        end
        format.json { render :show, status: :created, location: @participation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @participation.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /participations/1 or /participations/1.json
  def update
    respond_to do |format|
      if @participation.update(participation_params)
        format.html do
          redirect_to participation_url(@participation),
                      notice: 'Participation was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @participation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @participation.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /participations/1 or /participations/1.json
  def destroy
    @participation.destroy!

    respond_to do |format|
      format.html do
        redirect_to participations_url,
                    notice: 'Participation was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_participation
    @participation = Participation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def participation_params
    params
      .require(:participation)
      .permit(:bet_id, :owner_id, :fee, :anonymous, :message)
  end

  def user_has_enough_balance?(user_id, participation_fee)
    user = User.find(user_id)
    user.balance.to_i >= participation_fee.to_i
  end

  def deduct_balance(user_id, amount)
    user = User.find(user_id)
    new_balance = user.balance.to_i - amount.to_i
    user.update(balance: new_balance)
  end
end
