require 'spec_helper'

describe Spree::QuotePresenter do
  include Spree::BaseHelper
  let(:quote) { create(:quote) }
  let(:quote1) { create(:quote, author_name: 'abc') }

  describe "#present" do
    context 'when data is blank' do
      it "returns decorated author_name" do
        expect(present(quote).author_name).to eq('Anonymous')
      end

      it "returns decorated published_at" do
        expect(present(quote).published_at).to eq('-')
      end

      it "returns decorated rank" do
        expect(present(quote).rank).to eq('-')
      end
    end

    context 'when data is present' do
      before do
        quote1.publish
        quote1.update(rank: 1)
      end

      it "returns decorated author_name" do
        expect(present(quote1).author_name).to eq('abc')
      end

      it "returns decorated published_at" do
        expect(present(quote1).published_at).to eq(pretty_time(quote1.published_at))
      end

      it "returns decorated rank" do
        expect(present(quote1).rank).to eq(1)
      end
    end
  end

end
