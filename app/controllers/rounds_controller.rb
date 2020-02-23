class RoundsController < ApplicationController
  def create
    current_game = Game.find_by!(uid: params[:game_uid])
    current_game.create_next_round!
    redirect_to game_path(current_game)
  end
end
