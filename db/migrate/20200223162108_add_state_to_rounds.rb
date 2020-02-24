class AddStateToRounds < ActiveRecord::Migration[6.0]
  def change
    add_column :rounds, :aasm_state, :string, null: false, default: :strategy_phase
  end
end
