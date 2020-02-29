class AddRevealedAgendaCardsToRounds < ActiveRecord::Migration[6.0]
  def change
    add_column :rounds, :revealed_agenda_cards, :jsonb, default: [], null: false
  end
end
