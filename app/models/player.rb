class Player < ApplicationRecord
  include SimpleUid

  validates :name, presence: true
  validates :faction, presence: true

  attribute :technologies, :value_object, default: []

  belongs_to :game

  def add_technology(key)
    update(technologies: technologies.push(Technology.find_by_key(key)))
  end

  def remove_technology(key)
    update(technologies: technologies.reject { |tech| tech.key == key })
  end
end
