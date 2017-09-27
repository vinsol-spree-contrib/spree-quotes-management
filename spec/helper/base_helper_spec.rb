require 'spec_helper'

describe Spree::BaseHelper, type: :helper do
  include Spree::Admin::BaseHelper
  let(:quote) { create(:quote) }

  context "#present" do
    it "returns object of presenter class" do
      expect(present(quote).class).to eq(Spree::QuotePresenter)
    end

  end

  context "#quote_states" do
    it "returns quote states" do
      expect(quote_states).to eq([['published', 'published'], ['draft', 'draft']])
    end
  end

end
