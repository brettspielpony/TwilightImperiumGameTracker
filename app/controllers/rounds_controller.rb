class RoundsController < ApplicationController
  before_action :load_current_game
  before_action :find_round

  def pick_strategy_cards
    round_params[:strategy_card_picks].each do |(player_id, strategy_card_keys)|
      @round.player_stats.create!(
        player: @current_game.players.find(player_id),
        picked_strategy_cards: strategy_card_keys.map { |key| StrategyCard.find_by(key: key) }
      )
    end
    @round.start_action_phase!

    redirect_to @current_game
  end

  def finish_action_phase
    @round.start_status_phase!

    redirect_to @current_game
  end

  def finish_status_phase
    if @round.may_start_agenda_phase?
      @round.start_agenda_phase!
    else
      @round.finish!
    end

    redirect_to @current_game
  end

  def pick_agenda_cards
    @round.revealed_agenda_cards = round_params[:agenda_cards].map { |key| AgendaCard.find_by(key: key) }
    @round.save!

    redirect_to @current_game
  end

  def finish_agenda_phase
    @round.finish!

    redirect_to @current_game
  end

  private

  def find_round
    @round ||= @current_game.rounds.find(params[:id]) # rubocop:disable Naming/MemoizedInstanceVariableName
  end

  def new_player_params
    params.require(:player).permit(:name, :faction).merge(game: @current_game)
  end

  def round_params
    params.require(:round).permit(strategy_card_picks: {}, agenda_cards: [])
  end

  def load_current_game
    @current_game ||= Game.find_by!(uid: params[:game_uid]) # rubocop:disable Naming/MemoizedInstanceVariableName
  end
end
