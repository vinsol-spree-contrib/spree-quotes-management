require 'spec_helper'

describe SpreeQuotesManagement::QuoteConfiguration, :type => :model do

  describe 'max_char_in_quotes' do
    it { expect(SpreeQuotesManagement::Config).to have_preference(:max_char_in_quotes) }
    it { expect(SpreeQuotesManagement::Config.preferred_max_char_in_quotes_type).to eq(:integer) }
    it { expect(SpreeQuotesManagement::Config.preferred_max_char_in_quotes_default).to eq(240) }
  end

  describe 'admin_quotes_per_page' do
    it { expect(SpreeQuotesManagement::Config).to have_preference(:admin_quotes_per_page) }
    it { expect(SpreeQuotesManagement::Config.preferred_admin_quotes_per_page_type).to eq(:integer) }
    it { expect(SpreeQuotesManagement::Config.preferred_admin_quotes_per_page_default).to eq(10) }
  end

  describe 'quotes_count' do
    it { expect(SpreeQuotesManagement::Config).to have_preference(:quotes_count) }
    it { expect(SpreeQuotesManagement::Config.preferred_quotes_count_type).to eq(:integer) }
    it { expect(SpreeQuotesManagement::Config.preferred_quotes_count_default).to eq(5) }
  end

  describe 'disable_quote' do
    it { expect(SpreeQuotesManagement::Config).to have_preference(:disable_quote) }
    it { expect(SpreeQuotesManagement::Config.preferred_disable_quote_type).to eq(:boolean) }
    it { expect(SpreeQuotesManagement::Config.preferred_disable_quote_default).to eq(false) }
  end

end
