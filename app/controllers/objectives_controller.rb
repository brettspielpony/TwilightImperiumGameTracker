class ObjectivesController < ApplicationController
  before_action :load_current_game

  def score
    player_stats = find_player_stats
    objective = Objective.find_by_key(params[:objective_key])
    player_stats.scored_public_objectives = player_stats.scored_public_objectives.push(objective)
    player_stats.save!

    redirect_to game_player_path(@current_game, player_stats.player)
  end

  private

  def find_player_stats
    @current_game.current_round.player_stats.find_by(player_id: params[:player_id])
  end


  def load_current_game
    @current_game ||= Game.find_by!(uid: params[:game_uid])
  end
end

