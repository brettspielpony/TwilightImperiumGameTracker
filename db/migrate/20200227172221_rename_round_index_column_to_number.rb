class RenameRoundIndexColumnToNumber < ActiveRecord::Migration[6.0]
  def change
    rename_column :rounds, :index, :number
  end
end
