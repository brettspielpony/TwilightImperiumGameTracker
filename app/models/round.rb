class Round < ApplicationRecord
  include AASM

  belongs_to :game
  has_many :player_stats, dependent: :destroy
  has_many :player, through: :player_stats

  attribute :revealed_objectives, :value_object, default: []

  before_create :set_started_at

  aasm do
    state :strategy_phase, initial: true
    state :action_phase
    state :agenda_phase
    state :finished, before_enter: :set_ended_at

    event :start_action_phase do
      transitions from: :strategy_phase, to: :action_phase
    end

    event :start_agenda_phase do
      transitions from: :strategy_phase, to: :agenda_phase
    end

    event :finish do
      transitions from: %i[action_phase agenda_phase], to: :finished
    end
  end

  private

  def set_started_at
    self.started_at = Time.zone.now
  end

  def set_ended_at
    self.ended_at = Time.zone.now
  end
end
