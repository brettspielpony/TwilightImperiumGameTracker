class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.references :game, index: true
      t.integer :index, null: false, default: 1

      t.datetime :started_at, null: false
      t.datetime :ended_at

      t.timestamps
    end
  end
end
