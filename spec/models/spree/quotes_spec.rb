require 'spec_helper'

describe Spree::Quote, type: :model do

  let!(:quote) { FactoryGirl.create(:quote) }
  let(:published_quote) { FactoryGirl.create(:published_quote, rank: 1) }
  let(:published_quote_without_rank) { FactoryGirl.create(:published_quote) }

  describe 'Constants' do
    it "expects whitelisted_ransackable_attributes constant to be ['description', 'state', 'author_name']" do
      expect(Spree::Quote.whitelisted_ransackable_attributes).to eq(['description', 'state', 'author_name'])
    end

    it "expects whitelisted_ransackable_associations constant to be ['user']" do
      expect(Spree::Quote.whitelisted_ransackable_associations).to eq(['user'])
    end
  end

  describe 'Relations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'Validation' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_numericality_of(:rank).is_less_than_or_equal_to(SpreeQuotesManagement::Config[:quotes_count]).is_greater_than(0) }
    it { is_expected.to allow_value('', nil).for(:rank) }
  end

  describe 'State machine' do

    it 'expects initial state to be draft' do
      expect(quote.state).to eq('draft')
    end

    it 'expects quote state to be published on event publish' do
      expect{ quote.publish }.to change{ quote.state }.to('published').from('draft')
    end

    it 'expects quote state to be draft on event unpublish' do
      expect { published_quote.unpublish }.to change { published_quote.state }.to('draft').from('published')
    end

    it 'expects published_at to be set on publish' do
      expect{ quote.publish }.to change{ quote.published_at }
    end

    it 'expects rank to be reset on unpublish' do
      expect { published_quote.unpublish }.to change { published_quote.rank }.to(nil)
    end
  end

  describe 'Callbacks' do
    context 'before_destroy' do
      describe '#restrict_if_published' do
        it 'add error' do
          expect(published_quote.destroy).to eq(false)
          expect(published_quote.errors[:Base]).to eq([Spree.t(:destroy_published_quote)])
        end
      end
    end

    context 'before_update' do
      describe '#update_quotes_of_same_rank' do
        before do
          @quote2 = FactoryGirl.create(:published_quote)
        end

        it 'set rank of quote1 to nil' do
          expect{ @quote2.update(rank: 1) }.to change{ published_quote.reload.rank }.from(1).to(nil)
        end
      end
    end
  end

  describe 'Scopes' do
    context '.published' do
      it { expect(::Spree::Quote.published).to eq([published_quote, published_quote_without_rank]) }
    end

    context '.ranked_quotes' do
      it { expect(::Spree::Quote.ranked_quotes).to eq([published_quote]) }
    end

    context '.published_and_without_rank' do
      it { expect(::Spree::Quote.published_and_without_rank).to eq([published_quote_without_rank]) }
    end
  end

  describe 'Class Methods' do
    context '.rank_range' do
      it { expect(::Spree::Quote.rank_range).to eq(1..::SpreeQuotesManagement::Config[:quotes_count]) }
    end

    context '.quotes_display_count' do
      it { expect(::Spree::Quote.quotes_display_count).to eq(::SpreeQuotesManagement::Config[:quotes_count]) }
    end

    context '.top_quotes' do
      context 'when all position are specified' do
        before do
          ::Spree::Quote.rank_range.to_a.each { |rank| create(:published_quote, rank: rank)}
        end
        it { expect(::Spree::Quote.top_quotes).to eq(::Spree::Quote.ranked_quotes.order(:rank)) }
      end

      context 'when all position are not specified' do
        before do
          ::Spree::Quote.rank_range.to_a.each { |rank| create(:published_quote, rank: rank)}
          @quote = ::Spree::Quote.find_by(rank: 1)
          @quote.update(rank: nil)
        end
        it { expect(::Spree::Quote.top_quotes).to eq(::Spree::Quote.ranked_quotes.order(:rank).to_a.unshift(@quote)) }
      end
    end
  end

end
