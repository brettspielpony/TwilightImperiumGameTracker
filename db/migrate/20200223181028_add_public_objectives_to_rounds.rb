class AddPublicObjectivesToRounds < ActiveRecord::Migration[6.0]
  def change
    add_column :rounds, :public_objectives, :string, array: true, default: [], null: false
  end
end
