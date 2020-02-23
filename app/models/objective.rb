class Objective
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :key, :string
  attribute :stage, :string
  attribute :title, :string
  attribute :description, :string

  class << self
    def all
      @objectives ||= objectives_for(key: "stage1_objectives", stage: "Stage 1") + objectives_for(key: "stage2_objectives", stage: "Stage 2")
    end

    def objectives_for(key:, stage:)
      I18n.t(key).map do |(objective_key, details)|
        new(key: objective_key, stage: stage, title: details[:title], description: details[:description])
      end
    end

    def find_by_key(key)
      all.detect { |tech| tech.key == key }
    end
  end

  class Serialization
    class << self
      def load(objectives)
        objectives.to_a.map { |key| Objective.find_by_key(key) }.map(&:dup)
      end

      def dump(objectives)
        objectives.map(&:key)
      end
    end
  end
end
