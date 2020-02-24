class ChangeScoredObjectivesToJsonb < ActiveRecord::Migration[6.0]
  def change
    remove_column :players, :scored_secret_objectives, :string
    remove_column :players, :scored_public_objectives, :string
    remove_column :player_stats, :scored_public_objectives, :string

    add_column :player_stats, :scored_public_objectives, :jsonb, default: []
    add_column :player_stats, :scored_secret_objectives, :jsonb, default: []
  end
end
