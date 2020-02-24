class AddPlayerScoresToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :player_scores, :jsonb, default: {}, null: false
  end
end
