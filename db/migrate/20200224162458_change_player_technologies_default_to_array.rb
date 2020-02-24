class ChangePlayerTechnologiesDefaultToArray < ActiveRecord::Migration[6.0]
  def up
    change_column_default :players, :technologies, []

    execute <<~SQL
      UPDATE players SET technologies = '[]' WHERE technologies IS NULL
    SQL
  end

  def down
    change_column_default :players, :technologies, nil
  end
end
