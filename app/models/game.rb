class Game < ApplicationRecord
  PLAYERS_COUNT_RANGE = 3..6

  class PlayerScores
    def self.load(hash)
      transform_key_and_values_to_integer(hash || {})
    end

    def self.dump(hash)
      hash.to_hash
    end

    def self.transform_key_and_values_to_integer(hash)
      hash.each_with_object({}) { |(k, v), h| h[k.to_i] = v.to_i }
    end
  end

  include SimpleUid
  include AASM

  serialize :map
  serialize :player_scores, PlayerScores

  has_many :rounds, dependent: :destroy
  has_many :players, dependent: :destroy
  belongs_to :winner, class_name: "Player", optional: true
  belongs_to :custodian_owner, class_name: "Player", optional: true

  before_create :set_started_at

  aasm do
    state :preparing, initial: true
    state :active
    state :closed, before_enter: :set_ended_at

    event :close do
      transitions from: %i[preparing active], to: :closed
    end

    event :start do
      transitions from: %i[preparing], to: :active, guard: :ready_to_start?
    end
  end

  def playtime
    (ended_at || Time.current) - started_at
  end

  def player_score(player)
    player_scores.fetch(player.id, 0)
  end

  def revealed_objectives
    @revealed_objectives ||= rounds.flat_map(&:revealed_objectives)
  end

  def custodian_taken?
    custodian_owner.present?
  end

  def current_round
    rounds.order(number: :asc).last
  end

  def current_round_number
    current_round&.number || 0
  end

  def next_round_number
    current_round_number + 1
  end

  def create_next_round(revealed_objectives:)
    round = rounds.build(number: next_round_number)
    round.revealed_objectives = revealed_objectives
    start! if preparing? if round.save
    round
  end

  def to_param
    uid
  end

  def enough_players?
    PLAYERS_COUNT_RANGE.include?(players.count)
  end

  def player_limit_reached?
    players.count >= PLAYERS_COUNT_RANGE.max
  end

  private

  def ready_to_start?
    enough_players?
  end

  def set_ended_at
    self.ended_at = Time.zone.now
  end

  def set_started_at
    self.started_at = Time.zone.now
  end
end
