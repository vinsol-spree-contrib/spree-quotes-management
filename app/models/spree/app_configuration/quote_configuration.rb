module SpreeQuotesManagement
  class QuoteConfiguration < Spree::Preferences::Configuration
    preference :max_char_in_quotes, :integer, default: 240
    preference :admin_quotes_per_page, :integer, default: 10
    preference :number_of_quotes_to_display, :integer, default: 5
  end
end
