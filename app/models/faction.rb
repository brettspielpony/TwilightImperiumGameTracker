class Faction
  def self.each
    I18n.t('factions').each { |key, details| yield(key, details[:title]) } if block_given?
  end
end
