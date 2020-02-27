class Round < ApplicationRecord
  include AASM

  belongs_to :game
  has_many :player_stats, dependent: :destroy
  has_many :player, through: :player_stats

  attribute :revealed_objectives, :value_object, default: []

  before_create :set_started_at

  validate :revealed_objectives_must_be_sufficient

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

  def revealed_objectives_must_be_sufficient
    if number == 1
      validate_objectives_for_first_round
    else
      validate_objectives_for_subsequent_rounds
    end
  end

  def validate_objectives_for_first_round
    return if has_expected_number_of_objectives? && different_objectives_picked?

    errors.add(:base, "You must select two different public objectives.")
  end

  def validate_objectives_for_subsequent_rounds
    return if has_expected_number_of_objectives?

    errors.add(:base, "You must select one public objective.")
  end

  def has_expected_number_of_objectives?
    revealed_objectives.compact.count == required_number_of_revealed_objectives
  end

  def different_objectives_picked?
    revealed_objectives.first != revealed_objectives.last
  end

  def required_number_of_revealed_objectives
    number == 1 ? 2 : 1
  end

  def set_started_at
    self.started_at = Time.zone.now
  end

  def set_ended_at
    self.ended_at = Time.zone.now
  end
end
