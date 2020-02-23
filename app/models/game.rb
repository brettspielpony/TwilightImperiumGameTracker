class Game < ApplicationRecord
  PLAYERS_COUNT_RANGE = 3..6

  include SimpleUid
  include AASM

  serialize :map

  has_many :players
  has_many :rounds
  has_one :winner, class_name: "Player"

  scope :active, -> { where(ended_at: nil) }

  before_create :set_started_at

  aasm do
    state :preparing, initial: true
    state :closed, before_enter: :set_ended_at

    event :close do
      transitions from: %i[preparing active], to: :closed
    end
  end

  def playtime
    (ended_at || Time.current) - started_at
  end

  def next_round_number
    (rounds.maximum(:index) || 0 ) + 1
  end

  def create_next_round!
    rounds.create(index: next_round_number)
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

  def set_ended_at
    self.ended_at = Time.zone.now
  end

  def set_started_at
    self.started_at = Time.zone.now
  end
end
