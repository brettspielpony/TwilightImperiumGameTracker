class Technology < ValueObject
  attribute :requires, :string
  attribute :color, :string

  def type
    case color
    when 'B' then :propulsion
    when 'G' then :bionic
    when 'R' then :warfare
    when 'Y' then :cybernetic
    else
      :other
    end
  end
end
