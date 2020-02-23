class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :uid, null: false
      t.string :name, null: false
      t.string :faction, null: false

      t.string :scored_public_objectives, array: true, default: []
      t.string :scored_secret_objectives, array: true, default: []
      t.string :technologies, array: true, default: []

      t.references :game, index: true

      t.timestamps
    end
  end
end
