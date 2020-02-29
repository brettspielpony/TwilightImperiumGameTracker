class Player < ApplicationRecord
  include SimpleUid

  belongs_to :game
  has_many :player_stats
  has_many :rounds, through: :player_stats

  validates :name, presence: true
  validates :faction, presence: true
  validates :seat_number, presence: true

  attribute :technologies, :value_object, default: []

  before_create :add_starting_technologies

  def scored_objective?(objective)
    player_stats.any? { |player_stat| player_stat.scored_public_objectives.include?(objective) }
  end

  def scored_secret_objectives
    @scored_secret_objectives ||= player_stats.flat_map(&:scored_secret_objectives)
  end

  def can_score_another_secret_objective?
    scored_secret_objectives.count < 3
  end

  def owns_castodian?
    game.custodian_owner == self
  end

  def currently_speaker?
    game.current_round.speaker == self
  end

  private

  def add_starting_technologies
    self.technologies = I18n.t("factions.#{faction}.starting_tech").compact.map { |key| Technology.find_by_key(key) }
  end
end
