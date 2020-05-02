class StrategyCard < ValueObject
  attribute :title, :string
  attribute :description, :string
  attribute :initiative_order, :integer

  def title_for_select
    "&#1010#{initiative_order + 1}; #{title}".html_safe # rubocop:disable Rails/OutputSafety
  end
end
