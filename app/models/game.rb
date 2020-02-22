class Game < ApplicationRecord
  include SimpleUid

  serialize :map

  before_create :set_started_at

  def set_started_at
    self.started_at = Time.zone.now
  end
end
