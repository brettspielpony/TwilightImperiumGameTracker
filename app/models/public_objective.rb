class PublicObjective < ValueObject
  attribute :stage, :string
  attribute :description, :string

  def self.stage_one
    all.select { |objective| objective.stage == 'one' }
  end

  def self.stage_two
    all.select { |objective| objective.stage == 'two' }
  end
end
