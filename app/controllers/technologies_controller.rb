class TechnologiesController < ApplicationController
  def show
    @technology = Technology.find_by(key: params[:key])
  end

  def create
    current_game = load_current_game
    player = current_game.players.find(params[:player_id])
    player.technologies << Technology.find_by(key: params.require(:technology).required(:key))
    player.save
    redirect_to game_player_path(current_game, player)
  end

  def destroy
    current_game = load_current_game
    player = current_game.players.find(params[:player_id])
    player.technologies.reject! { |tech| tech.key == params[:key] }
    player.save

    redirect_to game_player_path(current_game, player)
  end

  private

  def load_current_game
    Game.find_by!(uid: params[:game_uid])
  end
end
