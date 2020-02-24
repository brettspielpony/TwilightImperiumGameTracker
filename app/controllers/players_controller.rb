class PlayersController < ApplicationController
  before_action :load_current_game

  def show
    @player = @current_game.players.find(params[:id])
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(new_player_params)

    if @player.save
      redirect_to @current_game
    else
      render :new
    end
  end

  def destroy
    player = @current_game.players.find(params[:id])
    player.destroy!

    redirect_to @current_game
  end

  private

  def new_player_params
    params.require(:player).permit(:name, :faction, :seat_number).merge(game: @current_game)
  end

  def load_current_game
    @current_game ||= Game.find_by!(uid: params[:game_uid])
  end
end
