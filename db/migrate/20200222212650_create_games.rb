class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :uid
      t.string :name
      t.datetime :started_at
      t.datetime :ended_at
      t.integer :victory_points
      t.jsonb :custodian
      t.string :map

      t.timestamps
    end
  end
end
