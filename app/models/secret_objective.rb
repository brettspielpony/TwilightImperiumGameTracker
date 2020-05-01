class SecretObjective < ValueObject
  attribute :phase, :string
  attribute :description, :string

  def self.action_phase
    all.select { |objective| objective.phase == 'action' }
  end

  def self.status_phase
    all.select { |objective| objective.phase == 'status' }
  end
end
