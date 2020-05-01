class ValueObjectType < ActiveRecord::Type::Json
  def cast(value)
    return value if value.blank?

    case value
    when Array
      value.map do |data|
        next data unless data.is_a?(Hash)

        cast_to_value_object(data)
      end
    when Hash
      cast_to_value_object(value)
    when ValueObject
      value
    end
  end

  def cast_to_value_object(data)
    data = data.stringify_keys
    klass = data['class'].constantize
    klass.find_by_key(data['key'])
  end

  def deserialize(value)
    cast(super)
  end
end
