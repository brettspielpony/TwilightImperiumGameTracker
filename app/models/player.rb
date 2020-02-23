class Player < ApplicationRecord
  include SimpleUid

  serialize :technologies, Technology::Serialization

  belongs_to :game

  def add_technology(key)
    update(technologies: technologies.push(Technology.find_by_key(key)))
  end

  def remove_technology(key)
    update(technologies: technologies.reject { |tech| tech.key == key })
  end
end
