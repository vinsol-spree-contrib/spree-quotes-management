class Spree::QuotePresenter < BasePresenter

  def created_at
    @model.created_at.to_time.strftime('%B %e at %l:%M %p')
  end

  def published_at
    @model.published_at.to_time.strftime('%B %e at %l:%M %p') if @model.published_at.present?
  end

end
