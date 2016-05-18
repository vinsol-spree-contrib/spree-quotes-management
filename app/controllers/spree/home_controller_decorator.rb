Spree::Admin::HomeController.class_eval do
  before_filter :set_top_quotes, only: :index
  before_filter :set_new_quote, only: :index

  private

  def set_top_quotes
    # get quotes with rank
    @top_quotes = Spree::Quote.with_rank

    # get random quotes
    indexes_for_random_quotes = (1..::SpreeQuotesManagement::Config[:quotes_count]).to_a - @top_quotes.pluck(:rank)
    random_quotes_count = indexes_for_random_quotes.count
    @top_quotes += Spree::Quote.published_and_without_rank.sample(random_quotes_count)

    #arrange quotes
    @top_quotes.each { |quote| quote.index = quote.rank || indexes_for_random_quotes.pop }
    @top_quotes.sort_by! { |quote| quote.index }
  end

  def set_new_quote
    @quote = Spree::Quote.new
  end
end
