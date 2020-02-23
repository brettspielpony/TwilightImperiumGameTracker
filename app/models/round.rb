class Round < ApplicationRecord
  belongs_to :game

  before_create :set_started_at

  private

  def set_started_at
    self.started_at = Time.zone.now
  end
end
