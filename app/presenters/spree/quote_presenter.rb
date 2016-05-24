class Spree::QuotePresenter < BasePresenter

  def author_name
    @model.author_name.presence || 'Anonymous'
  end

  def published_at
    @model.published? ? h.pretty_time(@model.published_at) : '-'
  end

  def rank
    @model.rank || '-'
  end

end
