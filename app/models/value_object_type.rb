class ValueObjectType < ActiveRecord::Type::Json
  def cast(value)
    return value if value.blank?

    case value
    when Array
      value.map do |data|
        klass = data['class'].constantize
        klass.find_by_key(data['key'])
      end
    end
  end

  def deserialize(value)
    cast(super)
  end
end
