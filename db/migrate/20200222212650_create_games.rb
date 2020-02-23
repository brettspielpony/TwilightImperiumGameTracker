class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :uid, null: false, unique: true
      t.string :name, null: false
      t.datetime :started_at, null: false
      t.datetime :ended_at
      t.integer :victory_points, null: false
      t.string :map
      t.string :aasm_state, null: false, default: :preparing

      t.timestamps
    end
  end
end
