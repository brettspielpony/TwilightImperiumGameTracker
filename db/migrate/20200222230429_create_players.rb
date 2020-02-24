class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :uid, null: false, unique: true
      t.string :name, null: false
      t.string :faction, null: false

      t.string :scored_public_objectives, array: true, default: []
      t.string :scored_secret_objectives, array: true, default: []
      t.string :technologies, array: true, default: []

      t.references :game, index: true, null: false

      t.timestamps
    end

    add_foreign_key :players, :games
  end
end
