class CreatePlayerStats < ActiveRecord::Migration[6.0]
  def change
    # rubocop:disable Rails/CreateTableWithTimestamps
    create_table :player_stats do |t|
      t.string :strategy_card, null: false

      t.references :player, index: true, null: false
      t.references :round, index: true, null: false
    end
    # rubocop:enable Rails/CreateTableWithTimestamps

    add_foreign_key :player_stats, :players
    add_foreign_key :player_stats, :rounds
  end
end
