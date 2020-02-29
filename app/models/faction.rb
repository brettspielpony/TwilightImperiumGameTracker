class Faction
  def self.each
    if block_given?
      I18n.t("factions").each { |key, details| yield(key, details[:title]) }
    end
  end
end
