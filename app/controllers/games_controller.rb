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
    objectives_for_round = public_objectives_params[:public_objectives].map { |key| PublicObjective.find_by_key(key) }
    round = game.create_next_round(revealed_objectives: objectives_for_round)
    if !round.valid?
      flash[:alert] = round.errors.full_messages.join("\n")
    end

    redirect_to game
  end

  private

  def update_game_params
    params.require(:game).permit([{player_scores: {}}, :custodian_owner_id])
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
