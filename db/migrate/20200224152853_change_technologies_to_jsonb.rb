class ChangeTechnologiesToJsonb < ActiveRecord::Migration[6.0]
  def change
    remove_column :players, :technologies
    add_column :players, :technologies, :jsonb
  end
end
