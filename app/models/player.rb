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
end
