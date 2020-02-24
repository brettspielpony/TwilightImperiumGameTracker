class AddScoredPublicObjectivesToPlayerStats < ActiveRecord::Migration[6.0]
  def change
    add_column :player_stats, :scored_public_objectives, :string, array: true, default: [], null: false
  end
end
