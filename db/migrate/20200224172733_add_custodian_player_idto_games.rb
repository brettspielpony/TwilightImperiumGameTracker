class AddCustodianPlayerIdtoGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :custodian_owner_id, :integer
  end
end
