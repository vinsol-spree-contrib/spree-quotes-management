Spree::HomeController.class_eval do
  before_action :set_top_quotes, :set_new_quote, only: :index

  private


  def set_top_quotes
    @top_quotes = Spree::Quote.top_quotes
  end

  def set_new_quote
    @quote = Spree::Quote.new
  end
end
