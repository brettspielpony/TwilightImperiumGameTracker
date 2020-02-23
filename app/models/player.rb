class Player < ApplicationRecord
  include SimpleUid

  belongs_to :game
end
