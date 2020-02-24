module ApplicationHelper
  def available_factions_for_game(game)
    selected_factions = game.players.map(&:faction)
    I18n.t("factions").to_a.reject { |(faction_key, _faction_name)| selected_factions.include?(faction_key.to_s) }
  end

  def available_tech_for_player(player)
    Technology.all.reject { |tech| player.technologies.any? { |player_tech| player_tech.key == tech.key } }
  end

  def strategy_cards
    I18n.t("strategy_cards").to_a.map { |(key, details)| [key, "&#1010#{details[:initiative_order].to_i + 1}; #{details[:title]}".html_safe] }.sort_by(&:last)
  end

  def available_objectives_for_game(game)
    (PublicObjective.all - game.revealed_objectives)
  end
end
