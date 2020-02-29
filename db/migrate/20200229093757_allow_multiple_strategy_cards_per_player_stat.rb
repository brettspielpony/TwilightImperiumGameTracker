class AllowMultipleStrategyCardsPerPlayerStat < ActiveRecord::Migration[6.0]
  def change
    add_column :player_stats, :picked_strategy_cards, :jsonb, default: []
    remove_column :player_stats, :strategy_card
  end
end
