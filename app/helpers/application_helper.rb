module ApplicationHelper
  def available_factions_for_game(game)
    selected_factions = game.players.map(&:faction)
    I18n.t("factions").to_a.reject { |(faction_key, _faction_name)| selected_factions.include?(faction_key.to_s) }
  end

  def available_tech_for_player(player)
    Technology.all.map do |tech|
      [tech.key, tech.title]
    end.reject { |(tech_key, _title)| player.technologies.any? { |tech| tech.key == tech_key } }
  end
end
