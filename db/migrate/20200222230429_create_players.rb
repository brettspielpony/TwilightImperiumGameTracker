class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :uid
      t.string :name
      t.string :faction
      t.references :game, index: true

      t.timestamps
    end
  end
end
