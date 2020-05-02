class ObjectivesController < ApplicationController
  before_action :load_current_game

  def score_public
    objective = PublicObjective.find_by(key: params[:objective_key])

    player_stats = find_player_stats
    player_stats.scored_public_objectives << objective
    player_stats.save!

    redirect_to game_player_path(@current_game, player_stats.player)
  end

  def score_secret
    objective = SecretObjective.find_by(key: params[:objective_key])

    player_stats = find_player_stats
    player_stats.scored_secret_objectives << objective
    player_stats.save!

    redirect_to game_player_path(@current_game, player_stats.player)
  end

  private

  def find_player_stats
    @current_game.players.find(params[:player_id]).player_stats.last
  end

  def load_current_game
    @current_game ||= Game.find_by!(uid: params[:game_uid]) # rubocop:disable Naming/MemoizedInstanceVariableName
  end
end
