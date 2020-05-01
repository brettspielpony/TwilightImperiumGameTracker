class Faction < ValueObject
  attribute :starting_tech, :array_of_strings, default: []
end
