class Faction
  def self.each
    if block_given?
      I18n.t("factions").each { |faction_key, faction_name| yield(faction_key, faction_name) }
    end
  end
end
