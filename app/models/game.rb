class Game < ApplicationRecord
  PLAYERS_COUNT_RANGE = 3..6

  include SimpleUid
  include AASM

  serialize :map

  has_many :players
  has_many :rounds
  has_one :winner, class_name: "Player"

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

  def active_public_objectives
    @active_public_objectives ||= rounds.map { |round| round.public_objectives }.flatten
  end

  def current_round
    rounds.order(index: :asc).last
  end

  def current_round_number
    current_round&.index || 0
  end

  def next_round_number
    current_round_number + 1
  end

  def create_next_round(public_objectives:)
    round = rounds.build(index: next_round_number)
    round.public_objectives = public_objectives.map { |key| Objective.find_by_key(key) }
    round.save!
    start! if preparing?
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
