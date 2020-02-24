class AddSeatNumberToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :seat_number, :integer
  end
end
