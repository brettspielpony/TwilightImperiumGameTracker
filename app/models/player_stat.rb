class PlayerStat < ApplicationRecord
  belongs_to :round
  belongs_to :player

  attribute :scored_public_objectives, :value_object, default: []
  validates :scored_public_objectives, array_inclusion: { in: PublicObjective.all }

  attribute :scored_secret_objectives, :value_object, default: []
  validates :scored_secret_objectives, array_inclusion: { in: SecretObjective.all }

  attribute :picked_strategy_cards, :value_object, default: []
  validates :picked_strategy_cards, array_inclusion: { in: StrategyCard.all }
end
