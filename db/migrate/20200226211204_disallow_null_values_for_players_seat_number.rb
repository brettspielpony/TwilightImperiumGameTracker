class DisallowNullValuesForPlayersSeatNumber < ActiveRecord::Migration[6.0]
  def change
    change_column_null :players, :seat_number, false
  end
end
