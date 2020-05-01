class ArrayInclusionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, values = [])
    rejected = (values - options.fetch(:in, [])).uniq
    return if rejected.blank?

    record.errors.add(attribute, :inclusion, options.except(:in).merge(rejected: rejected, value: values))
  end
end
