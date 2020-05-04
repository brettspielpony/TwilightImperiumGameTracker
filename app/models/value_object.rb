class ValueObject
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :key, :string
  attribute :title, :string

  def self.table_name
    name.tableize
  end

  def self.all
    @all ||= I18n.t(table_name).map do |key, details|
      new(key: key, **details)
    end
  end

  # NB: This keeps Rubocop happy since it mimics ActiveRecord interface
  def self.find_by(key:)
    all.detect { |obj| obj.key.to_s == key.to_s }
  end

  def id
    key
  end

  def persisted?
    true
  end

  def inspect
    "'<#{self.class.name}: #{attributes}>'"
  end

  def as_json(*_opts)
    {
      class: self.class.name,
      key: key
    }
  end
end
