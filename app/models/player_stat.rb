class PlayerStat < ApplicationRecord
  belongs_to :round
  belongs_to :player

  serialize :scored_public_objectives, Objective::Serialization
end
