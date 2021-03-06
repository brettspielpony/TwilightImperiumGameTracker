class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.integer :index, null: false, default: 1
      t.datetime :started_at, null: false
      t.datetime :ended_at

      t.references :game, index: true, null: false
      t.timestamps
    end

    add_foreign_key :rounds, :games
  end
end
