require 'spec_helper'

describe Spree::HomeController, type: :controller do
  let(:user) { create(:user) }

  before do
    allow(controller).to receive_messages :spree_current_user => user
    user.spree_roles << Spree::Role.find_or_create_by(name: 'admin')
  end

  def do_index
    get :index
  end

  describe '#index' do

    it 'sets new quote' do
      do_index
      expect(assigns(:quote).new_record?).to eq(true)
    end

    before do
      ::Spree::Quote.rank_range.to_a.each { |rank| create(:published_quote, rank: rank)}
    end

    it 'sets top quotes' do
      do_index
      expect(assigns(:top_quotes)).to eq(::Spree::Quote.ranked_quotes.order(:rank))
    end
  end

end
