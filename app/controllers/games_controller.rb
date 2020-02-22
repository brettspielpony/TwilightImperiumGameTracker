class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(new_game_params)

    if @game.save
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def new_game_params
    params.require(:game).permit(:name, :map, :victory_points)
  end
end
