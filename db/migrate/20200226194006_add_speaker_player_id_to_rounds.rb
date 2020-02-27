class AddSpeakerPlayerIdToRounds < ActiveRecord::Migration[6.0]
  def change
    add_column :rounds, :speaker_id, :integer, null: false
  end
end
