class CreatePlayerStats < ActiveRecord::Migration[6.0]
  def change
    create_table :player_stats do |t|
      t.string :strategy_card, null: false

      t.references :player, index: true
      t.references :round, index: true
    end
  end
end
