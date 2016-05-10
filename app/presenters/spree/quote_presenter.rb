class Spree::QuotePresenter < BasePresenter

  def created_at
    @model.created_at.to_time.strftime('%B %e at %l:%M %p')
  end

end
