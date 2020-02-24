module ApplicationHelper
  def available_factions_for_game(game)
    selected_factions = game.players.map(&:faction)
    I18n.t("factions").to_a.reject { |(faction_key, _faction_name)| selected_factions.include?(faction_key.to_s) }
  end

  def available_tech_for_player(player)
    Technology.all.reject { |tech| player.technologies.any? { |player_tech| player_tech.key == tech.key } }
  end

  def strategy_cards
    I18n.t("strategy_cards").to_a.map { |(key, details)| [key, details[:title]] }
  end

  def available_public_objectives_for_game(game)
    selected_objectives = game.active_public_objectives
    objectives = Objective.all.reject { |objective| selected_objectives.any? { |selected_objective| selected_objective.key == objective.key } }
    ["Stage 1", "Stage 2"].map do |stage|
      [stage, objectives.select { |obj| obj.stage == stage }.map { |obj| [obj.title, obj.key] }]
    end
  end
end
