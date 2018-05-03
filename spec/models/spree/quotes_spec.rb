require 'spec_helper'

describe Spree::Quote, type: :model do

  let!(:quote) { FactoryBot.create(:quote) }
  let(:published_quote) { FactoryBot.create(:published_quote, rank: 1) }
  let(:published_quote_without_rank) { FactoryBot.create(:published_quote) }

  describe 'Schema' do
    describe 'Fields' do
      it { is_expected.to have_db_column(:description).of_type(:text) }
      it { is_expected.to have_db_column(:rank).of_type(:integer) }
      it { is_expected.to have_db_column(:state).of_type(:string) }
      it { is_expected.to have_db_column(:user_id).of_type(:integer) }
      it { is_expected.to have_db_column(:author_name).of_type(:string) }
      it { is_expected.to have_db_column(:published_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end
  end

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
    context "space left in carousel" do
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

    context "space not left in carousel" do
      before { 5.times { FactoryBot.create(:published_quote) } }

      it 'expects quote state to not change on event publish' do
        expect{ quote.publish }.to_not change{ quote.state }
      end
    end
  end

  describe 'Callbacks' do
    context 'before_destroy' do
      describe '#restrict_if_published' do
        it 'adds error' do
          expect(published_quote.destroy).to eq(false)
          expect(published_quote.errors[:Base]).to eq([Spree.t(:destroy_published_quote)])
        end
      end
    end

    context 'before_update' do
      describe '#update_quotes_of_same_rank' do
        before do
          @quote2 = FactoryBot.create(:published_quote)
        end

        it 'sets rank of other quote with same rank to nil' do
          expect{ @quote2.update(rank: 1) }.to change{ published_quote.reload.rank }.from(1).to(nil)
        end
      end
    end
  end

  describe 'Scopes' do
    describe '.published' do
      it 'returns published quotes' do
        expect(::Spree::Quote.published).to eq([published_quote, published_quote_without_rank])
      end
    end

    describe '.ranked_quotes' do
      it 'returns ranked quotes' do
        expect(::Spree::Quote.ranked_quotes).to eq([published_quote])
      end
    end

    describe '.published_and_without_rank' do
      it 'returns published and without rank quotes' do
        expect(::Spree::Quote.published_and_without_rank).to eq([published_quote_without_rank])
      end
    end
  end

  describe 'Class Methods' do
    describe '.rank_range' do
      it 'returns rank range' do
        expect(::Spree::Quote.rank_range).to eq(1..::SpreeQuotesManagement::Config[:quotes_count])
      end
    end

    describe '.quotes_display_count' do
      it 'returns quotes display count' do
        expect(::Spree::Quote.quotes_display_count).to eq(::SpreeQuotesManagement::Config[:quotes_count])
      end
    end

    describe '.top_quotes' do
      context 'when all positions are specified' do
        before do
          ::Spree::Quote.rank_range.to_a.each { |rank| create(:published_quote, rank: rank)}
        end
        it 'returns top quotes' do
          expect(::Spree::Quote.top_quotes).to eq(::Spree::Quote.ranked_quotes.order(:rank))
        end
      end

      context 'when all positions are not specified' do
        before do
          ::Spree::Quote.rank_range.to_a.each { |rank| create(:published_quote, rank: rank)}
          @quote = ::Spree::Quote.find_by(rank: 1)
          @quote.update(rank: nil)
        end
        it 'returns top quotes with random published quotes at unspecified positions' do
          expect(::Spree::Quote.top_quotes).to eq(::Spree::Quote.ranked_quotes.order(:rank).to_a.unshift(@quote))
        end
      end
    end
  end

end
