module ApplicationHelper
  def available_factions_for_game(game)
    (Faction.all - game.players.map(&:faction))
  end

  def available_seats_for_game(game)
    seats_taken_in_game = game.players.pluck(:seat_number).compact
    1.upto(6).reject { |seat_number| seat_number.in?(seats_taken_in_game) }.map { |seat| [seat, seat] }
  end

  def available_tech_for_player(player)
    Technology.all.reject { |tech| player.technologies.any? { |player_tech| player_tech.key == tech.key } }
  end

  def strategy_cards
    StrategyCard.all.sort_by(&:initiative_order)
  end

  def available_secret_objectives_for_player(player)
    (SecretObjective.all - player.scored_secret_objectives)
  end

  def available_public_objectives_for_game(game)
    (PublicObjective.all - game.revealed_objectives)
  end

  def available_agenda_cards_for_game(game)
    (AgendaCard.all - game.revealed_agenda_cards)
  end

  def image_tag_for_technology(technology)
    image_tag "tech_icon_#{technology.type}.png", class: 'technology-icon'
  end

  def image_tag_for_objective(objective)
    if objective.respond_to?(:stage)
      image_tag "public_objectives_stage_#{objective.stage}.png", class: 'objective-icon'
    else
      image_tag 'secret_objectives.png', class: 'objective-icon'
    end
  end

  def image_tag_for_faction(faction)
    image_tag "#{faction.key}.png", class: "faction-icon"
  end
end
