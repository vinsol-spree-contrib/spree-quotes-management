class Spree::QuoteDecorator < Draper::Decorator

  delegate :created_at

  def formatted_created_at
    created_at.to_time.strftime('%B %e at %l:%M %p')
  end

end
