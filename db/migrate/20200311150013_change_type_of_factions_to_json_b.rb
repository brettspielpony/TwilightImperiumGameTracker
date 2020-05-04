class ChangeTypeOfFactionsToJsonB < ActiveRecord::Migration[6.0]
  def change
    remove_column :players, :faction, :string
    add_column :players, :faction, :jsonb, default: {}
  end
end
