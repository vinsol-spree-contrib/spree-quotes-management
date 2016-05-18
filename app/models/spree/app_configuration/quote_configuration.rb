module SpreeQuotesManagement
  class QuoteConfiguration < Spree::Preferences::Configuration
    preference :max_char_in_quotes, :integer, default: 240
    preference :admin_quotes_per_page, :integer, default: 10
    preference :quotes_count, :integer, default: 5
    preference :disable_quote?, :boolean, default: false
  end
end
