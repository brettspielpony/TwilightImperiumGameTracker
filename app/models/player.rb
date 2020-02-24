class Player < ApplicationRecord
  include SimpleUid

  validates :name, presence: true
  validates :faction, presence: true

  attribute :technologies, :value_object, default: []

  belongs_to :game
end
