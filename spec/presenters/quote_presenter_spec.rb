require 'spec_helper'

describe Spree::QuotePresenter do
  include Spree::BaseHelper
  let(:quote) { create(:quote) }
  let(:quote1) { create(:quote, author_name: 'abc') }

  describe "#author_name" do
    context 'when author_name is blank' do
      it "returns decorated author_name" do
        expect(present(quote).author_name).to eq('Anonymous')
      end
    end

    context 'when author_name is present' do
      it "returns decorated author_name" do
        expect(present(quote1).author_name).to eq('abc')
      end
    end
  end

  describe "#published_at" do
    context 'when published_at is blank' do
      it "returns decorated published_at" do
        expect(present(quote).published_at).to eq('-')
      end
    end

    context 'when published_at is present' do
      it "returns decorated published_at" do
        quote1.publish
        expect(present(quote1).published_at).to eq(pretty_time(quote1.published_at))
      end
    end
  end

  describe "#rank" do
    context 'when rank is blank' do
      it "returns decorated rank" do
        expect(present(quote).rank).to eq('-')
      end
    end

    context 'when rank is present' do
      before do
        quote1.publish
        quote1.update(rank: 1)
      end

      it "returns decorated rank" do
        expect(present(quote1).rank).to eq(1)
      end
    end
  end

end
