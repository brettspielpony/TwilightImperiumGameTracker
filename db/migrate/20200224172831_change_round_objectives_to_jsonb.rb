class ChangeRoundObjectivesToJsonb < ActiveRecord::Migration[6.0]
  def change
    remove_column :rounds, :public_objectives, :string

    add_column :rounds, :revealed_objectives, :jsonb, default: []
  end
end
