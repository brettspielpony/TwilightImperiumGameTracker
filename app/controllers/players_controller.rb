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

  def player_params
    params.require(:player).permit(:name, :faction, :seat_number)
  end

  def new_player_params
    player_params.merge(
      faction: Faction.find_by(key: player_params[:faction]),
      game: @current_game
    )
  end

  def load_current_game
    @current_game ||= Game.find_by!(uid: params[:game_uid]) # rubocop:disable Naming/MemoizedInstanceVariableName
  end
end
