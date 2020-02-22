module ApplicationHelper
  def available_factions_for_game(game)
    selected_factions = game.players.map(&:faction)
    I18n.t("factions").to_a.reject { |(faction_key, _faction_name)| selected_factions.include?(faction_key.to_s) }
  end
end
