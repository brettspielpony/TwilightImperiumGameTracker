class GamesController < ApplicationController
  def show
    @game = Game.find_by!(uid: params[:uid])
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

  private

  def new_game_params
    params.require(:game).permit(:name, :map, :victory_points)
  end
end
