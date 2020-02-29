class GamesController < ApplicationController
  def show
    @game = find_game
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(new_game_params)

    if @game.save
      redirect_to game_url(@game)
    else
      render :new
    end
  end

  def update
    game = find_game
    game.update(update_game_params)

    redirect_to game
  end

  def close
    game = find_game
    game.close!

    redirect_to root_url
  end

  def start_next_round
    game = find_game
    objectives_for_round = new_rounds_params[:public_objectives].map { |key| PublicObjective.find_by_key(key) }
    speaker = game.players.find(new_rounds_params[:speaker_id])
    game.create_next_round(revealed_objectives: objectives_for_round, speaker: speaker)

    redirect_to game
  end

  def restart_current_round
    game = find_game
    game.restart_current_round

    redirect_to game
  end

  private

  def update_game_params
    params.require(:game).permit([{player_scores: {}}, :custodian_owner_id])
  end

  def new_rounds_params
    params.require(:game).permit([{public_objectives: []}, :speaker_id])
  end

  def find_game
    Game.find_by!(uid: params[:uid])
  end

  def new_game_params
    params.require(:game).permit(:name, :map, :victory_points)
  end
end
