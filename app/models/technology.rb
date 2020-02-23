class Technology
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :key, :string
  attribute :title, :string
  attribute :requires, :string
  attribute :color, :string

  class << self
    def all
      @techs ||= I18n.t("technologies").map do |(tech_key, details)|
        new(key: tech_key, title: details[:title], color: details[:color], requires: details[:requires])
      end
    end

    def find_by_key(key)
      all.detect { |tech| tech.key == key }
    end
  end

  class Serialization
    class << self
      def load(technologies)
        technologies.to_a.map { |tech_key| Technology.find_by_key(tech_key) }.map(&:dup)
      end

      def dump(technologies)
        technologies.map(&:key)
      end
    end
  end
end
