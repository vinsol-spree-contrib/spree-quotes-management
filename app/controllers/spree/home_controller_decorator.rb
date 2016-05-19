Spree::Admin::HomeController.class_eval do
  before_filter :set_top_quotes, :set_new_quote, only: :index

  private


  def set_top_quotes

    # get quotes with rank
    top_quotes = Spree::Quote.with_rank.order(rank: :desc).to_a

    # get random quotes
    random_quotes_count = Spree::Quote.top_quotes_count - top_quotes.count
    random_quotes = Spree::Quote.published_and_without_rank.sample(random_quotes_count)

    #arrange quotes
    @top_quotes = Spree::Quote.rank_range.to_a.map do |rank|
      top_quotes.last.try(:rank) == rank ? top_quotes.pop : random_quotes.pop
    end.compact

  end

  def set_new_quote
    @quote = Spree::Quote.new
  end
end
