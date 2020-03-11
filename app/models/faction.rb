class Faction < ValueObject
  attribute :title, :string
  attribute :starting_tech, :array_of_strings, default: []
end
