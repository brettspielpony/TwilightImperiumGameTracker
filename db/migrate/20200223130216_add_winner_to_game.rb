class AddWinnerToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :winner_id, :integer
    add_foreign_key :games, :players, column: :winner_id
  end
end
