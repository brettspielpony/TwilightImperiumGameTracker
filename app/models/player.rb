class Player < ApplicationRecord
  include SimpleUid

  belongs_to :game
  has_many :player_stats
  has_many :rounds, through: :player_stats

  validates :name, presence: true
  validates :faction, presence: true

  attribute :technologies, :value_object, default: []

  def scored_objective?(objective)
    player_stats.any? { |player_stat| player_stat.scored_public_objectives.include?(objective) }
  end

  def owns_castodian?
    game.custodian_owner == self
  end

  def currently_speaker?
    game.current_round.speaker == self
  end
end
