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
    game.update(player_scores_params)

    redirect_to game
  end

  def close
    game = find_game
    game.close!

    redirect_to root_url
  end

  def start_next_round
    game = find_game
    game.create_next_round(public_objectives: public_objectives_params[:public_objectives])

    redirect_to game
  end

  private

  def player_scores_params
    params.require(:game).permit(player_scores: {})
  end

  def public_objectives_params
    params.require(:game).permit(public_objectives: [])
  end

  def find_game
    Game.find_by!(uid: params[:uid])
  end

  def new_game_params
    params.require(:game).permit(:name, :map, :victory_points)
  end
end
