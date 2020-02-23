class TechnologiesController < ApplicationController
  def show
    @technology = Technology.find_by_key(params[:key])
  end

  def create
    current_game = load_current_game
    player = current_game.players.find(params[:player_id])
    player.add_technology(params.require(:technology).required(:key))
    redirect_to game_player_path(current_game, player)
  end

  def destroy
    current_game = load_current_game
    player = current_game.players.find(params[:player_id])
    player.remove_technology(params[:key])
    redirect_to game_player_path(current_game, player)
  end

  private

  def load_current_game
    Game.find_by!(uid: params[:game_uid])
  end
end
