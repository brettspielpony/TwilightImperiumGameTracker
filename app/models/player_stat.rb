class PlayerStat < ApplicationRecord
  belongs_to :round
  belongs_to :player

  attribute :scored_public_objectives, :value_object, default: []
  attribute :scored_secret_objectives, :value_object, default: []
  attribute :picked_strategy_cards, :value_object, default: []
end
