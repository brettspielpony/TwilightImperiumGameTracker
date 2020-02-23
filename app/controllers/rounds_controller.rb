class RoundsController < ApplicationController
  before_action :load_current_game

  def pick_strategy_cards
    round = @current_game.rounds.find(params[:id])
    players_and_picks = params[:round][:strategy_card_picks].permit!.to_h.each do |(player_id, strategy_card_key)|
      round.player_stats.create!(player: @current_game.players.find(player_id), strategy_card: strategy_card_key)
    end

    round.start_action_phase!

    redirect_to @current_game
  end

  def finish_action_phase
    round = @current_game.rounds.find(params[:id])
    round.finish!

    redirect_to @current_game
  end

  private

  def new_player_params
    params.require(:player).permit(:name, :faction).merge(game: @current_game)
  end

  def load_current_game
    @current_game ||= Game.find_by!(uid: params[:game_uid])
  end
end
