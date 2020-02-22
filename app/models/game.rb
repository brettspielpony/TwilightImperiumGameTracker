class Game < ApplicationRecord
  PLAYERS_COUNT_RANGE = 3..6

  include SimpleUid

  serialize :map

  has_many :players

  before_create :set_started_at

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

  def set_started_at
    self.started_at = Time.zone.now
  end
end
